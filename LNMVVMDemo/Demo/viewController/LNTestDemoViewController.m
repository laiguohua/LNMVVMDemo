//
//  LNTestDemoViewController.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNTestDemoViewController.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "LNDemoViewModel.h"
#import "LNTabelDemoDelegateModel.h"

@interface LNTestDemoViewController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LNDemoViewModel *viewModel;
@property (nonatomic,strong)LNTabelDemoDelegateModel *delegateModel;

@end

@implementation LNTestDemoViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TableViewDemo";
    
}

- (void)ln_addSubviews{
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
- (void)ln_bindViewModel{
//    LNTabelDemoDelegateModel 里不用实现任何东西，就可实现tableView的代理,基类已经实现
    @weakify(self);
    self.delegateModel = [[LNTabelDemoDelegateModel alloc] initWithDataArr:self.viewModel.dataSoure tableView:self.tableView cellClassNames:@[@"LNTableDemoCell"] useAutomaticDimension:NO cellDidSelectedBlock:^(NSIndexPath *indexPath, LNDemoModel *cellModel) {
        //cell点击事件,传出相应的下标和对应的模型
        cellModel.isChoose = !cellModel.isChoose;
        @strongify(self);
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }];
    
    [self.viewModel loadLocalTableDemoData:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    
}

#pragma mark - lazyload
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [LNTabelDemoDelegateModel createTableWithStyle:UITableViewStylePlain rigistNibCellNames:@[@"LNTableDemoCell"] rigistClassCellNames:nil];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (LNDemoViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [LNDemoViewModel new];
    }
    return _viewModel;
}
@end
