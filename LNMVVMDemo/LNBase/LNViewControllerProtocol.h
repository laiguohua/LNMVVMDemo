//
//  LNViewControllerProtocol.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LNViewControllerProtocol <NSObject>

@optional
- (void)ln_bindViewModel;
- (void)ln_addSubviews;
//设置导航
- (void)ln_layoutNavigation;
//数据请求
- (void)ln_getNewData;

@end
