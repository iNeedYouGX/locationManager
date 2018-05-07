//
//  ViewController.m
//  location
//
//  Created by JasonBourne on 2018/5/7.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "ViewController.h"
#import "GXLocationTool.h"

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GXLocationTool *tool = [GXLocationTool shareLocationTool] ;
    [tool getCurrentLocation:^(CLLocationCoordinate2D coordinator, CLPlacemark *mark){
        NSLog(@"%f --- %f\n %@", coordinator.longitude, coordinator.latitude, mark);
    }];
}

@end
