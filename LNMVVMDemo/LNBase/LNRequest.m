//
//  LNRequest.m
//  CityShakeHands
//
//  Created by Mr.lai on 2018/9/18.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "LNRequest.h"
#import "NSObject+parser.h"
#import "LNBaseParseManager.h"
#import "MBManager.h"

@interface LNRequest()

@property (nonatomic,strong,readwrite)LNHttpConfig *lastHttpConfig;

@property (nonatomic,strong)NSMutableDictionary *taskDic;

@end

@implementation LNRequest

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (RACCommand *)startHttpWithRequestConfig:(LNHttpConfig *)model{
    self.lastHttpConfig = model;
    return [self reStartHttp];
}

- (RACCommand *)reStartHttp{
    if(self.lastHttpConfig){
        RACCommand *command = [self lk_baseRequestCommond];
        [command execute:self.lastHttpConfig];
        if(self.requestDelegate.requestStatusBlock){
            self.requestDelegate.requestStatusBlock(YES, self.lastHttpConfig.apiFlag);
        }
        return command;
    }
    return nil;
}

//统一处理错误信息
- (void)handleErrmsg:(NSString *)errmsg errorCodeNum:(NSNumber *)errorCodeNum httpConfig:(LNHttpConfig *)config  subscriber:(id<RACSubscriber>)subscriber{
    NSDictionary *userInfo;
    if(config){
        userInfo = @{@"httpConfig":config, @"errmsg":errmsg?:@"网络出错"};
    }else{
        userInfo = @{@"errmsg":errmsg?:@"网络出错"};
    }
    NSError *error = [NSError errorWithDomain:@"" code:errorCodeNum?errorCodeNum.integerValue:-1 userInfo:userInfo];
    [subscriber sendError:error];
    [subscriber sendCompleted];
    
}

//检测数据的返回类型是否符合，不符合的话内部会作错误处理发送
- (BOOL)checkDataWithClass:(Class)aclass data:(id)data httpConfig:(LNHttpConfig *)config subscriber:(id<RACSubscriber>)subscriber{
    if(data && [data isKindOfClass:aclass]){
        NSInteger retCode = [[data valueForKey:[LNBaseParseManager shareManager].codeKey] integerValue];
        if(retCode == [LNBaseParseManager shareManager].successCode){
            return YES;
        }
        [self handleErrmsg:[data valueForKey:[LNBaseParseManager shareManager].errorMessageKey] errorCodeNum:@(retCode) httpConfig:config subscriber:subscriber];
        return NO;
    }
    [self handleErrmsg:nil errorCodeNum:nil httpConfig:config subscriber:subscriber];
    return NO;
}

- (void)handleSuccessData:(id)data code:(NSInteger)code message:(NSString *)message httpConfig:(LNHttpConfig *)config  subscriber:(id<RACSubscriber>)subscriber{
#ifdef DEBUG
    //    NSLog(@"请求的结果：%@",data);
#endif
    
    if([self checkDataWithClass:NSClassFromString(config.checkClassName) data:data httpConfig:config subscriber:subscriber]){
        //保留原始数据,供外部选择性地使用
        config.orginData = data;
        data = [data valueForKey:[LNBaseParseManager shareManager].dataKey];
        if(config.parserBlock){
            id adata = [data ln_parseMake:^(LNParserMarker *make) {
                config.parserBlock(make);
            }];
            id resultData = RACTuplePack(adata,config);
            [subscriber sendNext:resultData];
        }else{
            id resultData = RACTuplePack(data,config);
            [subscriber sendNext:resultData];
        }
        [subscriber sendCompleted];
        
    }
}

- (RACCommand *)lk_baseRequestCommond{
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(LNHttpConfig *config) {
        return [self lk_requestSignalWithHttpConfig:config];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id result) {
        RACTupleUnpack(id data,LNHttpConfig *config) = result;
        if(self.requestDelegate.resultBlock){
            self.requestDelegate.resultBlock(YES, config.apiFlag, 0, data,config.orginData, [config.orginData valueForKey:[LNBaseParseManager shareManager].errorMessageKey]);
        }else if(self.requestDelegate && [self.requestDelegate respondsToSelector:@selector(requestCompleWithSuccess:apiFlag:code:data:orginData:message:)]){
            [self.requestDelegate requestCompleWithSuccess:YES apiFlag:config.apiFlag code:0 data:data orginData:config.orginData message:[config.orginData valueForKey:[LNBaseParseManager shareManager].errorMessageKey]];
        }
        if(self.requestDelegate.requestStatusBlock){
            self.requestDelegate.requestStatusBlock(NO, config.apiFlag);
        }
        
    }];
    
    [command.errors subscribeNext:^(NSError *error) {
        LNHttpConfig *config = error.userInfo[@"httpConfig"];
        if(self.requestDelegate.resultBlock){
            self.requestDelegate.resultBlock(NO, config.apiFlag, error.code, nil,config.orginData, error.userInfo[@"errmsg"]);
        }else if(self.requestDelegate && [self.requestDelegate respondsToSelector:@selector(requestCompleWithSuccess:apiFlag:code:data:orginData:message:)]){
            [self.requestDelegate requestCompleWithSuccess:NO apiFlag:config.apiFlag code:error.code data:nil orginData:config.orginData message:error.userInfo[@"errmsg"]];
        }
        if(self.requestDelegate.requestStatusBlock){
            self.requestDelegate.requestStatusBlock(NO, config.apiFlag);
        }
        if(config.errorShowMessage){
            [MBManager showHUDWithMessage:error.userInfo[@"errmsg"]];
        }
    }];
    return command;
}

- (RACSignal *)lk_requestSignalWithHttpConfig:(LNHttpConfig *)config{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionTask *task;
        if(config.method == LK_GET){
            task = [[LNHttpManager shareManager] get:config.apiStr
                                           parameter:config.parameter
                                             hudType:config.hudType
                                            progress:[config.progressBlock copy]
                                             success:^(NSInteger code, id response, NSString *message,NSURLSessionTask *task) {
                                                 LNHttpConfig *saveConfig = [self.taskDic objectForKey:@(task.taskIdentifier)];
                                                 [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
                                                 [self handleSuccessData:response code:code message:message httpConfig:saveConfig subscriber:subscriber];
                                                 
                                             }
                                             failure:^(NSInteger code, id response, NSString *message,NSURLSessionTask *task) {
                                                 LNHttpConfig *saveConfig = [self.taskDic objectForKey:@(task.taskIdentifier)];
                                                 [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
                                                 [self handleErrmsg:message errorCodeNum:@(code) httpConfig:saveConfig subscriber:subscriber];
                                                 
                                             }];
            
        }else if(config.method == LK_POST){
            
            task = [[LNHttpManager shareManager] post:config.apiStr
                                            parameter:config.parameter
                                              hudType:config.hudType
                                             progress:[config.progressBlock copy]
                                              success:^(NSInteger code, id response, NSString *message,NSURLSessionTask *task) {
                                                  LNHttpConfig *saveConfig = [self.taskDic objectForKey:@(task.taskIdentifier)];
                                                  [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
                                                  [self handleSuccessData:response code:code message:message httpConfig:saveConfig subscriber:subscriber];
                                                  
                                              }
                                              failure:^(NSInteger code, id response, NSString *message,NSURLSessionTask *task) {
                                                  
                                                  LNHttpConfig *saveConfig = [self.taskDic objectForKey:@(task.taskIdentifier)];
                                                  [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
                                                  [self handleErrmsg:message errorCodeNum:@(code) httpConfig:saveConfig subscriber:subscriber];
                                                  
                                              }];
        }
        
        if(task){
            [self.taskDic setObject:config forKey:@(task.taskIdentifier)];
        }
        return nil;
    }];
    return signal;
}

- (NSMutableDictionary *)taskDic{
    if(!_taskDic){
        _taskDic = [NSMutableDictionary dictionary];
    }
    return _taskDic;
}

@end
