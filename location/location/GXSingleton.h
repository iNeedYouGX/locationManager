//
//  GXSingleton.h
//  单例模式
//
//  Created by JasonBourne on 2018/5/6.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//


//单例的.h文件
#define GXSingletonH(name) + (instancetype)share##name;

//单例的.m文件
#define GXSingletonM(name) \
static id _instance; \
 \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
 \
+ (instancetype)share##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[super alloc] init]; \
    }); \
    return _instance; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
