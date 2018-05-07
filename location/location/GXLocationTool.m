//
//  GXLocationTool.m
//  location
//
//  Created by JasonBourne on 2018/5/7.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "GXLocationTool.h"

@interface GXLocationTool()<CLLocationManagerDelegate>
@property (nonatomic, copy) SuccessBlock recordBlock;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@end


@implementation GXLocationTool
GXSingletonM(LocationTool)
- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager
{
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            if (@available(iOS 8.0, *)) {
                //获取info.plist文件的信息
                NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
                if (infoDic[@"NSLocationWhenInUseUsageDescription"]) {
                    [_locationManager requestWhenInUseAuthorization];
                } else if (infoDic[@"NSLocationAlwaysAndWhenInUseUsageDescription"]) {
                    [_locationManager requestAlwaysAuthorization];
                } else {
                    NSLog(@"在ios8.0之后定位, 请在info.plist文件中加NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationWhenInUseUsageDescription");
                }
                if (@available(iOS 9.0, *)) {
                    if (infoDic[@"NSLocationAlwaysAndWhenInUseUsageDescription"] && [infoDic[@"UIBackgroundModes"] containsObject:@"location"]) {
                        [_locationManager setAllowsBackgroundLocationUpdates:YES];
                    }
                } else {
                    NSLog(@"在iOS 9中如果想要后台定位, 需要勾选BackgroundModes的location updates");
                }
            }
        }
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"请您确认定位服务是否开启" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        if ([vc isKindOfClass:[UIViewController class]]) {
            
            [vc presentViewController:alertController animated:YES completion:nil];
        } else {
            UINavigationController *nav = (UINavigationController *)vc;
            [nav.topViewController presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        self.recordBlock(location.coordinate, [placemarks lastObject]);
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager startUpdatingLocation];
}



- (void)getCurrentLocation:(SuccessBlock)block
{
    _recordBlock = block;
    [self.locationManager startUpdatingLocation];
}




@end
