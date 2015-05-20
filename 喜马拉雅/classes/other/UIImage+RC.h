//
//  UIImage+RC.h
// 
//
//  Created by apple on 14-4-14.
//  Copyright (c) 2014年 Raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RC)
/**
 *  返回一张纯色的图片
 *
 *  @param color 颜色
 *
 *  @return 
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;


/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (instancetype)resizableImage:(NSString *)name;


/**
 *  图片剪裁（圆形，带圆环）
 *
 *  @param name        图片
 *  @param borderWidth 边框的大小
 *  @param borderColor 边框的颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (instancetype)circleImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
