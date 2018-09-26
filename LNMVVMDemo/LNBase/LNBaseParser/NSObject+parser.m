//
//  NSObject+parser.m
//  LNMVVMDemo
//
//  Created by lgh on 2017/12/14.
//  Copyright © 2017年 lgh. All rights reserved.
//

#import "NSObject+parser.h"

@implementation NSObject (parser)

- (id)ln_parseMake:(void(^)(LNParserMarker *make))block{
    BOOL enable = [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSArray class]];
    NSAssert(enable, @"只有字典和数组才可以解析");
    LNParserMarker *amaker = [[LNParserMarker alloc] initWithData:self];
    block(amaker);
    return [amaker parserData];
}

@end
