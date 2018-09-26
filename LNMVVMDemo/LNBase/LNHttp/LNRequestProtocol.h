//
//  LNRequestProtocol.h
//  CityShakeHands
//
//  Created by Mr.lai on 2018/9/26.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络请求结果的回调,外部关心这个结果即可，或者子类对这个回调再次封装,也可以实现代理的方式来接收回调结果,二选一，优先block方式,接口多推荐使用代理方法
typedef void(^requestResultBlock)(BOOL success,NSInteger apiFlag,NSInteger code ,id data ,id orginData,NSString *message);

@protocol LNRequestProtocol <NSObject>

@property (nonatomic,copy)void(^requestStatusBlock)(BOOL isRunning,NSInteger apiFlag);

//请求回调
@property (nonatomic,copy)requestResultBlock resultBlock;

@optional
- (void)requestCompleWithSuccess:(BOOL)success apiFlag:(NSInteger)apiFlag code:(NSInteger)code data:(id)data orginData:(id)orginData message:(NSString *)message;

@end
