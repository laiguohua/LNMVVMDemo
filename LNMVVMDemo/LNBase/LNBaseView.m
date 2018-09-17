//
//  LNBaseView.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNBaseView.h"

@implementation LNBaseView

@synthesize ln_ActionBlock = _ln_ActionBlock;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self ln_setUpSubViews];
    }
    return self;
}


- (void)ln_setUpSubViews {}

- (void)ln_bindViewModel:(id<LNViewModelProtocol>)viewMode{};

- (void)ln_safeViewActionBlock:(UIControl *)actionControl infor:(id)infor{
    if(self.ln_ActionBlock){
        self.ln_ActionBlock(actionControl, infor);
    }
}

+ (id)ln_loadFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][0];
}

@end
