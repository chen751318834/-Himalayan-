//
//  RCTextViewTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTextViewTool : NSObject
/**
 *  返回一个带有属性的文字
 *
 *  @param text 普通文字
 *
 *  @return 带有属性的文字
 */
+ (NSAttributedString *)attributedTextWithText:(NSString *)text;
@end
