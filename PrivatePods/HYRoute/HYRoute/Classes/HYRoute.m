//
//  HYRoute.m
//  HYRoute_Tests
//
//  Created by 邱弘宇 on 2018/11/16.
//  Copyright © 2018 YHQiu@github.com. All rights reserved.
//

#import "HYRoute.h"

@implementation HYRoute

+ (instancetype)route{
    static HYRoute *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

@end
