//
//  RCSpecialText.m
//  高仿微博
//
//  Created by Raychen on 15/4/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSpecialText.h"
#import "MJExtension.h"
@implementation RCSpecialText
MJCodingImplementation
- (NSString *)description{
    return [NSString stringWithFormat:@"%@----%@",self.text,NSStringFromRange(self.range)];
    
}

@end
