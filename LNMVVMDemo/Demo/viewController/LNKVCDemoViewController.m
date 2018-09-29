//
//  LNKVCDemoViewController.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/29.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNKVCDemoViewController.h"
#import "LNKVCDemoModel.h"

@interface LNKVCDemoViewController ()

@end

@implementation LNKVCDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"KVC的强大用法";
    
    [self kvcTest1];
}
//kvc的运算
- (void)kvcTest1{
    NSArray *arr = [self getTestData];
    //如果growAge方法没有返回值，则这个数组的结果就是null的集合，有返回值则是返回值的集合
//    下面这两个方法效果是一样的，只是makeObjectsPerformSelector没有返回值,都是让数组里的每个对象都执行一次growAge方法
//    NSArray *handleArr = [arr valueForKeyPath:@"growAge"];
    [arr makeObjectsPerformSelector:@selector(growAge)];
    
    NSArray *a1 = [arr valueForKeyPath:@"name.uppercaseString"];
    [a1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
//    求和
    NSInteger totalAge = [[arr valueForKeyPath:@"@sum.age"] integerValue];
    CGFloat totalMoney = [[arr valueForKeyPath:@"@sum.money"] floatValue];
//    求平均值
    CGFloat avgAge = [[arr valueForKeyPath:@"@avg.age"] floatValue];
    CGFloat avgMoney = [[arr valueForKeyPath:@"@avg.money"] floatValue];
//    求最大值
    NSInteger maxAge = [[arr valueForKeyPath:@"@max.age"] integerValue];
//    求最小值
    NSInteger minAge = [[arr valueForKeyPath:@"@min.age"] integerValue];
//    求数组的个数
    NSInteger acount = [[arr valueForKeyPath:@"@count"] integerValue];
    NSLog(@"total age is :%ld  total money is %f  avg age is %f avg money is %f max age is %ld min age is %ld arr count is %ld",totalAge,totalMoney,avgAge,avgMoney,maxAge,minAge,acount);
    
    
    NSArray *names = @[@"lisi",@"zhangshang",@"wangwu",@"xiaoming",@"zhangshang"];
//    @unionOfObjects这个是不去重的
    //去重复,这里有两个zhangeshang ,执行之后会去掉重复的,如果直接对集合里的对象操作，属性值可写.self
    NSArray *newNames = [names valueForKeyPath:@"@distinctUnionOfObjects.self"];
    [newNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}

- (NSArray *)getTestData{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    for(int i=0;i<5;i++){
        LNKVCDemoModel *model = [LNKVCDemoModel new];
        model.name = [NSString stringWithFormat:@"name_%d",i];
        model.age = 10 + i;
        model.money = 100.5 + 100 * i;
        [arr addObject:model];
    }
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
