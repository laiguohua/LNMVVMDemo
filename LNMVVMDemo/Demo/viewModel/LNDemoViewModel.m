//
//  LNDemoViewModel.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNDemoViewModel.h"

@implementation LNDemoViewModel

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)ln_initialize{
    self.detailModel = [LNDemoModel new];
    self.detailModel.title = @"这是一个标题";
    self.detailModel.detailStr = @"这是内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情";
}

- (void)chageDetail{
//    模拟网络请求,延迟
//    真实的网络请求请使用self.netRequest
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.detailModel.isChoose = !self.detailModel.isChoose;
        if(self.detailModel.isChoose){
            self.detailModel.title = @"这是另外一个标题";
            self.detailModel.detailStr = @"这是哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        }else{
            self.detailModel.title = @"这是一个标题";
            self.detailModel.detailStr = @"这是内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情";
        }
    });
    
    
}

- (void)loadLocalTableDemoData:(void(^)(void))compleBlock{
    //模拟网络获取数据
    [self.dataSoure removeAllObjects];
    NSInteger count = arc4random() % 30 + 5;
    for(int i=0;i<count;i++){
        LNDemoModel *model = [LNDemoModel new];
        model.title = [NSString stringWithFormat:@"这是标题_%d",i];
        @autoreleasepool{
            NSString *detail = @"详情内容";
            NSInteger times = arc4random() % 5 + 3;
            for(int j=0;j<times;j++){
                detail = [NSString stringWithFormat:@"%@%@",detail,detail];
            }
            model.detailStr = detail;
        }
        model.isChoose = arc4random() % 2;
        [self.dataSoure addObject:model];
    }
    if(compleBlock){
        compleBlock();
    }
}

@end
