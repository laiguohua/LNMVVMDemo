//
//  LNTableDemoCell.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/26.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNTableDemoCell.h"
#import "LNDemoModel.h"

@implementation LNTableDemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 30;
    self.titleLabel.preferredMaxLayoutWidth = width;
    self.detailLabel.preferredMaxLayoutWidth = width;
}

- (void)ln_configCellWithInfor:(LNDemoModel *)model{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.detailStr;
    self.signView.backgroundColor = model.isChoose?[UIColor redColor]:[UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
