//
//  RCTextPart.m
//  高仿微博
//
//  Created by Raychen on 15/4/14.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTextPart.h"
#import "MJExtension.h"
@implementation RCTextPart
MJCodingImplementation
- (NSString *)description{
    return [NSString stringWithFormat:@"%@----%@----%d",self.text,NSStringFromRange(self.range),self.isEmotion];

}
@end
