//
//  LNDemoView.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNDemoView.h"
#import <ReactiveObjC/ReactiveObjC.h>

#import "LNDemoViewModel.h"

@interface LNDemoView()

@property (nonatomic,strong)LNDemoViewModel *viewModel;

@end

@implementation LNDemoView
- (void)dealloc{
    NSLog(@"%s",__func__);
}
- (void)ln_bindViewModel:(id<LNViewModelProtocol>)viewModel{
    self.viewModel = (LNDemoViewModel *)viewModel;
    //UI与数据绑定
    RAC(self.titleLabel,text) = RACObserve(self.viewModel.detailModel,title);
    RAC(self.detailLabel,text) = RACObserve(self.viewModel.detailModel,detailStr);
    RAC(self.aswitch,on) = RACObserve(self.viewModel.detailModel,isChoose);
    
}

- (IBAction)switchAction:(UISwitch *)sender {
    [self ln_safeViewActionBlock:sender infor:nil];
}

@end
