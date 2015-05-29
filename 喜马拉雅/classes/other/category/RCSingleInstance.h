//
//  RCSingleInstance.h
//
//
//  Created by Raychen on 15/1/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
// 单例对象

#ifndef _____RCSingleInstance_h
#define _____RCSingleInstance_h
//H文件的实现
#define RCSingleInstanceH(name) + (instancetype)shared##name;
//M文件的实现
#define RCSingleInstanceM(name) \
static id instance =nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance =[super allocWithZone:zone];\
    });\
    return instance;\
}\
+ (instancetype)shared##name{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance =[[self alloc]init];\
    });\
    return instance;\
}
#endif
