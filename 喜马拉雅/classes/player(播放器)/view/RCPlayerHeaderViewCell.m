//
//  RCPlayerHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerHeaderViewCell.h"
#import "RCConst.h"
#import "AFSoundManager.h"

@interface RCPlayerHeaderViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountButton;
@property (weak, nonatomic) IBOutlet UIImageView *largeIconView;
@property (weak, nonatomic) IBOutlet UIImageView *smallIconVIew;
@property (weak, nonatomic) IBOutlet UIImageView *avatorIconView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property(nonatomic,assign) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UISlider *pgogressView;

@end
@implementation RCPlayerHeaderViewCell

+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCPlayerHeaderViewCell" owner:nil options:nil]lastObject];
}
- (IBAction)back:(id)sender {
    if ([self.delegate respondsToSelector:@selector(back:)]) {
        [self.delegate back:self];
    }
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
/**
 *  播放音频
 *
 */
//- (void)playAudio:(RCAudio *)audio{
//
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",audio.docid] params:nil success:^(id json) {
//        self.playPauseButton.selected = YES;
//        RCPlayingAudio * palyingAudio = [RCPlayingAudio objectWithKeyValues:json[audio.docid][@"video"][0]];
//        if (self.isLocalData) {
//            [self playLoacalAudio:palyingAudio];
//        }else{
//            [self playRemoteAudio:palyingAudio.url_m3u8];
//        }
//
//        [UIImage circleImage:self.iconView.image borderWidth:0 borderColor:nil];
//
//        [self.iconView sd_setImageWithURL:[NSURL URLWithString:palyingAudio.cover] placeholderImage:[UIImage imageNamed:@"biz_audio_play_header_column_cover_default"]];
//
//    } failure:^(NSError *error) {
//        
//    }];
//}
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
//- (void)playRemoteAudio:(NSString *)url_m3u8{
//    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:url_m3u8 andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
//
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
@end
