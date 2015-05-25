//
//  RCSpecialText.h
//  高仿微博
//
//  Created by Raychen on 15/4/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSpecialText : NSObject
/**
 *  文字
 */
@property(copy,nonatomic) NSString * text;
/**
 *  文字的范围
 */
@property (nonatomic, assign)NSRange range;
@end
