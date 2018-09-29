//
//  LNKVCDemoModel.h
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/29.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNKVCDemoModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,assign)double money;

- (void)growAge;

@end
