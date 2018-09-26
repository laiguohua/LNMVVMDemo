//
//  LNTableDemoCell.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/26.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCellConfigDelegate.h"
@interface LNTableDemoCell : UITableViewCell<LCellConfigDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *signView;

@end
