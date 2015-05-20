//
//  RCNetWorkingTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCNetWorkingTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


+ (void)post:(NSString *)url params:(NSDictionary *)params data:(NSData *)data success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
