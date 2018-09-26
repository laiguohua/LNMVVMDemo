//
//  LNBaseViewModel.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/17.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNViewModelProtocol.h"
#import "LNRequest.h"

@interface LNBaseViewModel : NSObject<LNViewModelProtocol,LNRequestProtocol>
//数据源
@property (nonatomic,strong)NSMutableArray *dataSoure;

//请求回调
@property (nonatomic,copy)requestResultBlock resultBlock;

@property (nonatomic,copy)void(^requestStatusBlock)(BOOL isRunning,NSInteger apiFlag);

//网络请求
@property (nonatomic,strong)LNRequest *netRequest;

@end
