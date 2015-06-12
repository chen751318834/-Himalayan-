//
//  RCSearchResultList.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchResultList.h"
#import "MJExtension.h"
@implementation RCSearchResultList
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{@"ID":@"id"};
}
- (NSString *)description{
    return [NSString stringWithFormat:@"--%@---%@",_text,_title];
}
- (BOOL)isEqual:(RCSearchResultList *)other{
    return [self.title isEqualToString:other.title] && [self.ID isEqualToNumber:other.ID];;
}
@end
