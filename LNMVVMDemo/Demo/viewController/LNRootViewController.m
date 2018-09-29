//
//  LNRootViewController.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNRootViewController.h"
#import "LNDemoView.h"
#import "LNDemoViewModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "LNTestDemoViewController.h"
#import "LNKVCDemoViewController.h"

@interface LNRootViewController ()

@property (nonatomic,strong)LNDemoView *demoView;
@property (nonatomic,strong)LNDemoViewModel *viewModel;


@end

@implementation LNRootViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MVVM";
}

- (void)ln_addSubviews{
    
    [self.view addSubview:self.demoView];
    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIBarButtonItem *demoItem = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStylePlain target:self action:@selector(demoAction)];
    demoItem.tintColor = [UIColor blackColor];
    UIBarButtonItem *kvcItem = [[UIBarButtonItem alloc] initWithTitle:@"KVC" style:UIBarButtonItemStylePlain target:self action:@selector(kvcDemoAction)];
    kvcItem.tintColor = [UIColor blackColor];
//    self.navigationItem.rightBarButtonItems = @[demoItem,kvcItem];
    self.navigationItem.rightBarButtonItem = demoItem;
    
}
- (void)ln_bindViewModel{
    [self.demoView ln_bindViewModel:self.viewModel];
    @weakify(self);
    self.demoView.ln_ActionBlock = ^(id sender, id infor) {
        @strongify(self);
        [self.viewModel chageDetail];
    };
}

- (void)demoAction{
    LNTestDemoViewController *demoVC = [LNTestDemoViewController new];
    [self.navigationController pushViewController:demoVC animated:YES];
}
- (void)kvcDemoAction{
    LNKVCDemoViewController *kvcDemoVC = [LNKVCDemoViewController new];
    [self.navigationController pushViewController:kvcDemoVC animated:YES];
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
