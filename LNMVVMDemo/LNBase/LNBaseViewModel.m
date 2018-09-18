//
//  LNBaseViewModel.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNBaseViewModel.h"

@implementation LNBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    LNBaseViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel ln_initialize];
    }
    return viewModel;
}


- (void)ln_initialize{}

@end
