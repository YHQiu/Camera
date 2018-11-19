//
//  HYRouteRegister.h
//  HYRoute_Tests
//
//  Created by 邱弘宇 on 2018/11/14.
//  Copyright © 2018年 YHQiu@github.com. All rights reserved.
//
//

#import "HYRoute.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define HY_METHOD(__classname__) \
- (UIViewController *)routeTo##__classname__##withParam:(id)param;

#define HYRouteRegiter(__classname__) \
//UIViewController *HYRouteTo##__classname__##withParam(id param);
@interface HYRoute() \
HY_METHOD(__classname__) \
@end


//@class HYRoute; \
//#define HYRouteImplementationBegin(__classname__) \
//@implementation HYRoute \
//- (UIViewController *)routeTo##__classname__##withParam:(NSDictionary *)param{\
//\
//#define HYRouteImplementationEnd }@end

@interface HYRouteRegister : NSObject


@end

