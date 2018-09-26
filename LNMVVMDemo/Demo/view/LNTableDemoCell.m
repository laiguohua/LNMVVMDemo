//
//  LNTableDemoCell.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/26.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNTableDemoCell.h"
#import "LNDemoModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation LNTableDemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 30;
    self.titleLabel.preferredMaxLayoutWidth = width;
    self.detailLabel.preferredMaxLayoutWidth = width;
}

- (void)ln_configCellWithInfor:(LNDemoModel *)model{
//    采用RAC方式
    RAC(self.titleLabel,text) = [RACObserve(model, title) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.detailLabel,text) = [RACObserve(model, detailStr) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.signView,backgroundColor) = [[RACObserve(model, isChoose) takeUntil:self.rac_prepareForReuseSignal] map:^id _Nullable(id  _Nullable value) {
        return [value boolValue]?[UIColor redColor]:[UIColor lightGrayColor];
    }];
    
    //直接赋值的方式
//    self.titleLabel.text = model.title;
//    self.detailLabel.text = model.detailStr;
//    self.signView.backgroundColor = model.isChoose?[UIColor redColor]:[UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
