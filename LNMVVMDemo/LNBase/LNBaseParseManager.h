//
//  LNBaseParseManager.h
//  LaiKeBaoNew
//
//  Created by lgh on 2018/3/20.
//  Copyright © 2018年 lgh. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络请求数据返回解析时的key配置

@interface LNBaseParseManager : NSObject
//返回状态码解析时的key 默认为 retCode
@property (nonatomic,copy)NSString *codeKey;
//返回数据解析时的key 默认为 data 
@property (nonatomic,copy)NSString *dataKey;
//返回错误信息或信息解析时的key  默认为 retDesc
@property (nonatomic,copy)NSString *errorMessageKey;
//请求成功判断的code,默认为0
@property (nonatomic,assign)NSInteger successCode;

+ (LNBaseParseManager *)shareManager;

@end
