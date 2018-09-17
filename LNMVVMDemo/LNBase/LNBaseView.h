//
//  LNBaseView.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNViewProtocol.h"

@interface LNBaseView : UIView<LNViewProtocol>

@property (nonatomic, copy)void (^ln_ActionBlock)(UIControl *actionControl,id infor);

@end
