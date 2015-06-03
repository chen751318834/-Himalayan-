//
//  RCTextPart.h
//  高仿微博
//
//  Created by Raychen on 15/4/14.
//  Copyright (c) 2015年 raychen. All rights reserved.
// 图文混排的模型数据

#import <Foundation/Foundation.h>

@interface RCTextPart : NSObject
/**
 *  文字
 */
@property(copy,nonatomic) NSString * text;
/**
 *  文字的范围
 */
@property (nonatomic, assign)NSRange range;
/**
 *  是否是表情文字
 */
@property (nonatomic, assign,getter=isEmotion)BOOL emotion;

@property(nonatomic,assign,getter=isSpecialText) BOOL specialText;



@end
