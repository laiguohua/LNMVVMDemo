//
//  LNViewModelProtocol.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LNRequest;

@protocol LNViewModelProtocol <NSObject>
//网络请求对象
@property (nonatomic,strong)LNRequest *netRequest;

@optional
- (void)ln_initialize;

@end
