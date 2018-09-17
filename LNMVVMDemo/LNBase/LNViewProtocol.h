//
//  LNViewProtocol.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LNViewModelProtocol;

@protocol LNViewProtocol <NSObject>

//交互事件
@property (nonatomic, copy)void (^ln_ActionBlock)(UIControl *actionControl,id infor);

@optional
+ (id)ln_loadFromXib;
- (void)ln_setUpSubViews;
- (void)ln_bindViewModel:(id<LNViewModelProtocol>)viewModel;
- (void)ln_safeViewActionBlock:(UIControl *)actionControl infor:(id)infor;

@end
