//
//  LNBaseParseManager.m
//  LNMVVMDemo
//
//  Created by lgh on 2018/3/20.
//  Copyright © 2018年 lgh. All rights reserved.
//

#import "LNBaseParseManager.h"
static LNBaseParseManager *manager = nil;
@implementation LNBaseParseManager

+ (LNBaseParseManager *)shareManager{
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
        manager.codeKey = @"status";
        manager.dataKey = @"data";
        manager.errorMessageKey = @"message";
    });
    return manager;
}

@end
