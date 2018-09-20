//
//  LNTestDemoViewController.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNTestDemoViewController.h"
#import "LNDemoView.h"
#import "LNDemoViewModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LNTestDemoViewController ()

@property (nonatomic,strong)LNDemoView *demoView;
@property (nonatomic,strong)LNDemoViewModel *viewModel;

@end

@implementation LNTestDemoViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"DEMO";
    
}

- (void)ln_addSubviews{
    
    [self.view addSubview:self.demoView];
    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
- (void)ln_bindViewModel{
    [self.demoView ln_bindViewModel:self.viewModel];
    @weakify(self);
    self.demoView.ln_ActionBlock = ^(id sender, id infor) {
        @strongify(self);
        [self.viewModel chageDetail];
    };
}

#pragma mark - lazyload

- (LNDemoView *)demoView{
    if(!_demoView){
        _demoView = [LNDemoView ln_loadFromXib];
    }
    return _demoView;
}
- (LNDemoViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [LNDemoViewModel new];
    }
    return _viewModel;
}
@end
