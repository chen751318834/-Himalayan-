//
//  UIImageView+EXtension.m
//  网易新闻
//
//  Created by Raychen on 15/5/9.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "UIImageView+EXtension.h"
#import <CoreImage/CoreImage.h>


NSString *const kLBBlurredImageErrorDomain          = @"com.lucabernardi.blurred_image_additions";
CGFloat const   kLBBlurredImageDefaultBlurRadius    = 20.0;
@implementation UIImageView (EXtension)
/**
 * 开始动画
 */
- (void)startAnimationWithDuration:(NSTimeInterval )duration repeatCount:(NSUInteger)repeatount ImageCount:(NSUInteger)imageCount imageName:(NSString *)imageName {
    NSMutableArray * images = [NSMutableArray array];
    for (int i = 0; i<imageCount; i++) {
        NSString * imageNameStr = [[NSString stringWithFormat:@"%@.bundle",imageName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%.4d",imageName,i+1]];
        UIImage * image = [UIImage imageNamed:imageNameStr];

        [images addObject:image];

    }
    self.animationImages = images;
    self.animationDuration = duration;
    self.animationRepeatCount = repeatount;
    [self startAnimating];
}

#pragma mark - LBBlurredImage Additions

- (void)setImageToBlur: (UIImage *)image
            blurRadius: (CGFloat)blurRadius
       completionBlock: (LBBlurredImageCompletionBlock) completion

{
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *sourceImage = [CIImage imageWithCGImage:image.CGImage];

    

    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];

    if (!clamp) {

        NSError *error = [self errorForNotExistingFilterWithName:clampFilterName];
        if (completion) {
            completion(error);
        }
        return;
    }

    [clamp setValue:sourceImage
             forKey:kCIInputImageKey];

    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];


    NSString *gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter *gaussianBlur           = [CIFilter filterWithName:gaussianBlurFilterName];

    if (!gaussianBlur) {

        NSError *error = [self errorForNotExistingFilterWithName:gaussianBlurFilterName];
        if (completion) {
            completion(error);
        }
        return;
    }

    [gaussianBlur setValue:clampResult
                    forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:blurRadius]
                    forKey:@"inputRadius"];

    CIImage *gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];

    __weak UIImageView *selfWeak = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        CGImageRef cgImage = [context createCGImage:gaussianBlurResult
                                           fromRect:[sourceImage extent]];

        UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);

        dispatch_async(dispatch_get_main_queue(), ^{
            selfWeak.image = blurredImage;
            if (completion){
                completion(nil);
            }
        });
    });
}


- (NSError *)errorForNotExistingFilterWithName:(NSString *)filterName
{
    NSString *errorDescription = [NSString stringWithFormat:@"The CIFilter named %@ doesn't exist",filterName];
    NSError *error             = [NSError errorWithDomain:kLBBlurredImageErrorDomain
                                                     code:LBBlurredImageErrorFilterNotAvailable
                                                 userInfo:@{NSLocalizedDescriptionKey : errorDescription}];
    return error;
}
@end
