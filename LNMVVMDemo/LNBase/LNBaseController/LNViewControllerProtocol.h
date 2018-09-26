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
//以下两个在viewDidLoad里会调用
- (void)ln_bindViewModel;
- (void)ln_addSubviews;

//以下两个在viewWillAppear会调用
//设置导航
- (void)ln_layoutNavigation;
//数据请求
- (void)ln_getNewData;

@end
