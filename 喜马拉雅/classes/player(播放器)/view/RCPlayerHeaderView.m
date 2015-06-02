//
//  RCPlayerHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerHeaderView.h"
#import "RCConst.h"
#import "AFSoundManager.h"
#import "RCPlayerVIewModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "UIImageView+EXtension.h"
@interface RCPlayerHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountButton;
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallIconVIew;
@property (weak, nonatomic) IBOutlet UIImageView *avatorIconView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property(nonatomic,assign) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UISlider *pgogressView;
@property(nonatomic,strong) RCPlayerVIewModel  *viewmodel;
@property (weak, nonatomic) IBOutlet UIImageView *currentprogressImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bufferProgressImageView;
@property (weak, nonatomic) IBOutlet UIButton *progressButton;

@property (weak, nonatomic) IBOutlet UILabel *playProgressLabel;
@property(nonatomic,strong) NSTimer  *timer;
@end
@implementation RCPlayerHeaderView
- (void)panPregoressButton:(UIPanGestureRecognizer *)recognizer {
   CGPoint point = [recognizer translationInView:self.progressButton];
    self.progressButton.transform = CGAffineTransformTranslate(self.progressButton.transform,point.x, 0);
    [recognizer setTranslation:CGPointZero inView:self.progressButton];

}
//-  (RCPlayerVIewModel *)viewmodel{
//    if (!_viewmodel) {
//        self.viewmodel = [[RCPlayerVIewModel alloc]init];
//        self.viewmodel.trackId = self.trackId;
//    }
//    return _viewmodel;
//}
- (void)awakeFromNib{

    [super awakeFromNib];
    NSTimer * timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panPregoressButton:)];
    [self.progressButton addGestureRecognizer:pan];
}
-(void)update{
    [UIView animateWithDuration:1 animations:^{
        self.progressButton.transform = CGAffineTransformMakeTranslation(2, 0);
    }];

}
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCPlayerHeaderView" owner:nil options:nil]lastObject];

}
- (void)setPlayerInfo:(RCPlayerInfo *)playerInfo
{
    _playerInfo = playerInfo;

    self.topTitleLabel.text = playerInfo.title;

    [self setUpWithButton:self.playCountButton count:  [playerInfo.playtimes intValue]  title:nil];
    [self.smallIconVIew sd_setImageWithURL:[NSURL URLWithString: playerInfo.coverLarge] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
    [self.largeImageView sd_setImageWithURL:[NSURL URLWithString:playerInfo.coverLarge] placeholderImage:[UIImage imageNamed:@"sound_albumcover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.largeImageView setImageToBlur:image blurRadius:40 completionBlock:nil];
    }];
    [self.avatorIconView sd_setImageWithURL:[NSURL URLWithString:playerInfo.albumImage] placeholderImage:[UIImage imageNamed:@"sound_albumcover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatorIconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];

    self.userLabel.text = playerInfo.userInfo.nickname;
    self.countLabel.text = [NSString stringWithFormat:@"声音 %@ 粉丝 %@",[self countStr:[playerInfo.userInfo.tracks intValue]],[self countStr:[playerInfo.userInfo.followers intValue]]];
    self.descLabel.text =  playerInfo.userInfo.personDescribe;
    [self playRemoteAudio:playerInfo.playUrl64];
}
- (NSString *)countStr:(int)count {
    NSString * str = nil;

    if (count ==0) {

    }else{

        //小于1000
        if (count <10000) {  //小于1000
            str = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            str = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    }
    return str;
}

- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{

        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

        //大于14000  -> 1.4万

        //大于10445  -> 1万
        [button setTitle:title forState:UIControlStateNormal];

        
    }
    
}
- (IBAction)back:(id)sender {
    [RCNotificationCenter postNotificationName:backHomeNotification object:nil];
}
- (void)dealloc{

    [RCNotificationCenter removeObserver:self];
}
- (IBAction)playListButtonDidClicked:(UIButton *)sender {

}
- (IBAction)playHistoryButtonDidClicked:(UIButton *)sender {

}
- (IBAction)preButtonDidClicked:(UIButton *)sender {
    if (self.currentIndex <=0) {
        self.currentIndex = self.audios.count;
    }
    self.currentIndex --;
//    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];


}
- (IBAction)nextButtonDidClicked:(UIButton *)sender {
    if (self.currentIndex >= self.audios.count-1) {
        self.currentIndex = 0;
    }
    self.currentIndex ++;
//    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
- (IBAction)playAndPauseButtonDidClicked:(UIButton *)sender {
    if (sender.isSelected) {
        [[AFSoundManager sharedManager] pause];
        sender.selected = NO;
//        [self.iconView.layer removeAllAnimations];
    }else{
        [[AFSoundManager sharedManager] resume];
        sender.selected = YES;
//        [self.iconView.layer addAnimation:[self animation] forKey:nil];
    }

}
- (IBAction)pgoressValueChange:(UISlider *)sender {
    [[AFSoundManager sharedManager]moveToSection:sender.value];

}

#pragma mark - 播放本地音频
//- (void)playLoacalAudio:(RCPlayingAudio *)playingAudio{
//    [[AFSoundManager sharedManager] startPlayingLocalFileWithName:[NSString stringWithFormat:@"%@.mp3",playingAudio.alt] andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
//        if (!error) {
//
//            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"mm:ss"];
//            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
//            self.currentTimeLabel.text = [formatter stringFromDate:elapsedTimeDate];
//
//            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
//            self.totalTimeLabel.text = [formatter stringFromDate:timeRemainingDate];
//
//            self.progressView.value = percentage * 0.01;
//        } else {
//
//            NSLog(@"There has been an error playing the remote file: %@", [error description]);
//        }
//
//    }];
//
//}
//#pragma mark - 播放网络音频
- (void)playRemoteAudio:(NSString *)urlStr{
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:urlStr andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {

            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
            NSDate *totalTimeDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining+elapsedTime];

//        NSString *  elapsedTimeDateStr=   [formatter  stringFromDate:elapsedTimeDate];
            NSString *  totalTimeDateStr=   [formatter  stringFromDate:totalTimeDate];
            NSString *  timeRemainingDateStr=   [formatter  stringFromDate:timeRemainingDate];
            NSString *  elapsedTimeDateStr=   [formatter  stringFromDate:elapsedTimeDate];
          

            self.playProgressLabel.text = [NSString stringWithFormat:@"%@/%@",elapsedTimeDateStr,totalTimeDateStr];
            [self.progressButton setTitle:[NSString stringWithFormat:@"%@",elapsedTimeDateStr] forState:UIControlStateNormal];
            self.pgogressView.value = percentage * 0.01;
        } else {

            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }

    }];
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

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}
@end
