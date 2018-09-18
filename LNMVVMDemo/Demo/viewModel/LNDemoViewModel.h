//
//  LNDemoViewModel.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNDemoModel.h"

@interface LNDemoViewModel : LNBaseViewModel

@property (nonatomic,strong)LNDemoModel *detailModel;

@property (nonatomic,assign)BOOL isHiddenSwitch;

- (void)chageDetail;

@end
