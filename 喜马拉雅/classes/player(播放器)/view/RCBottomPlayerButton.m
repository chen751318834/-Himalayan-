//
//  RCBottomPlayerButton.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBottomPlayerButton.h"
#import "RCConst.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "RCAudioTool.h"
#import "RCplayerStatus.h"
#import "AFSoundManager.h"
@interface RCBottomPlayerButton ()
@property (weak, nonatomic) IBOutlet UIImageView *playingIconView;

@end
@implementation RCBottomPlayerButton
+ (instancetype)playerButton{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCBottomPlayerButton" owner:nil options:nil]lastObject];

}
- (void)awakeFromNib{
    [super awakeFromNib];
    [RCNotificationCenter addObserver:self selector:@selector(changeplayerStatus:) name:playingNotification object:nil];
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

}
-(void)changeplayerStatus:(NSNotification *)note{
    if ([AFSoundManager sharedManager].isPlaying) {
        [self.playingIconView.layer addAnimation:[self animation] forKey:nil];
        self.button.selected = NO;
    }else{
        [self.playingIconView.layer removeAllAnimations];
        self.button.selected = YES;

    }

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
+ (instancetype)playingAudioButton{
    NSMutableArray * childViews = [[UIApplication sharedApplication].keyWindow valueForKeyPath:@"subviews"];
    for (id childView in childViews) {
        if ([childView isKindOfClass:[RCBottomPlayerButton class]]) {
            NSLog(@"%@",childView);
            return childView;
        }
    }
    return nil;
}
@end
