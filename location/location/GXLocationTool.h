//
//  GXLocationTool.h
//  location
//
//  Created by JasonBourne on 2018/5/7.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXSingleton.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SuccessBlock)(CLLocationCoordinate2D coordinator, CLPlacemark *placemark);

@interface GXLocationTool : NSObject
GXSingletonH(LocationTool)
- (void)getCurrentLocation:(SuccessBlock)block;
@end
