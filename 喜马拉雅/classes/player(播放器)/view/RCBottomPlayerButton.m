//
//  RCBottomPlayerButton.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBottomPlayerButton.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface RCBottomPlayerButton ()
@property (weak, nonatomic) IBOutlet UIImageView *playingIconView;

@end
@implementation RCBottomPlayerButton
+ (instancetype)playerButton{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCBottomPlayerButton" owner:nil options:nil]lastObject];

}
- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)setImgSrc:(NSString *)imgSrc{
    _imgSrc = imgSrc;
    if (imgSrc) {
        self.playingIconView.hidden = NO;
        [self.playingIconView sd_setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.playingIconView.image  = [UIImage circleImage:image borderWidth:10 borderColor:[UIColor grayColor]];
        }];
    }else{
        self.playingIconView.hidden = YES;

    }
    [self.playingIconView.layer addAnimation:[self animation] forKey:nil];

}

- (CABasicAnimation *)animation{
    CABasicAnimation * transformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformAnim.fromValue          = @(0);
    transformAnim.toValue            = @(360 * M_PI/180);
    transformAnim.duration           = 10;
    transformAnim.repeatCount        = INFINITY;
    transformAnim.fillMode = kCAFillModeForwards;
    transformAnim.removedOnCompletion = NO;
    return transformAnim;
}
- (void)moveToTop{

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];

}
- (void)moveToBottom{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 70);
    } completion:nil];

}
@end
