//
//  UIImageView+EXtension.h
//
//  Created by Raychen on 15/5/9.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBBlurredImageCompletionBlock)(NSError *error);

extern NSString *const kLBBlurredImageErrorDomain;

extern CGFloat   const kLBBlurredImageDefaultBlurRadius;

enum LBBlurredImageError {
    LBBlurredImageErrorFilterNotAvailable = 0,
};


@interface UIImageView (EXtension)
/**
 * 开始动画
 */
- (void)startAnimationWithDuration:(NSTimeInterval )duration repeatCount:(NSUInteger)repeatount ImageCount:(NSUInteger)imageCount imageName:(NSString *)imageName;
/**
 *  模糊效果图片
 */
- (void)setImageToBlur: (UIImage *)image
            blurRadius: (CGFloat)blurRadius
       completionBlock: (LBBlurredImageCompletionBlock) completion;
@end
