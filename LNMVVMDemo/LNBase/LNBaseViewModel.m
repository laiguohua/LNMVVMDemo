//
//  LNBaseViewModel.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNBaseViewModel.h"

@implementation LNBaseViewModel

@synthesize netRequest = _netRequest;
@synthesize resultBlock = _resultBlock;
@synthesize requestStatusBlock = _requestStatusBlock;

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (id)init{
    self = [super init];
    if(self){
        [self ln_initialize];
    }
    return self;
}

- (void)ln_initialize{}

- (NSMutableArray *)dataSoure{
    if(!_dataSoure){
        _dataSoure = [NSMutableArray array];
    }
    return _dataSoure;
}

//请求对象
- (LNRequest *)netRequest{
    if(!_netRequest){
        _netRequest = [LNRequest new];
        _netRequest.requestDelegate = self;
    }
    return _netRequest;
}

@end
