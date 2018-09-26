//
//  LNRequest.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/18.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LNHttpConfig.h"
#import "LNRequestProtocol.h"

@interface LNRequest : NSObject

@property (nonatomic,strong,readonly)LNHttpConfig *lastHttpConfig;

@property (nonatomic,weak)id<LNRequestProtocol>requestDelegate;


//开启一个请求,对于开启一个接口，关注的应该是这个请求的配置，中间请求过程和结果处理无需关心，因为配置已经决定了请求和结果处理
- (RACCommand *)startHttpWithRequestConfig:(LNHttpConfig *)model;

//重新请求和最后一次发起请求一样的请求
- (RACCommand *)reStartHttp;

//统一处理错误信息
- (void)handleErrmsg:(NSString *)errmsg errorCodeNum:(NSNumber *)errorCodeNum httpConfig:(LNHttpConfig *)config subscriber:(id<RACSubscriber>)subscriber;

//检测数据的返回类型是否符合，不符合的话内部会作错误处理发送,外部只要关心为YES的情况
- (BOOL)checkDataWithClass:(Class)aclass data:(id)data  httpConfig:(LNHttpConfig *)config subscriber:(id<RACSubscriber>)subscriber;

@end
