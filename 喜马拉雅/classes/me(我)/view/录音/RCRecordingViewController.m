//
//  RCRecordingViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCRecordingViewController.h"
#import "RCRecordingViewCell.h"
#import "RCRecordingInstructionsViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "RCRecord.h"
#import "RCBottomPlayerButton.h"
#import "UIView+JHChainableAnimations.h"
#import "RCConst.h"
#import "AFSoundManager.h"
static NSString * const ID = @"recordingViewCell";
@interface RCRecordingViewController () <RCRecordingInstructionsViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) RCRecordingInstructionsViewController  *vc;
@property (weak, nonatomic) IBOutlet UIButton *sliderButton;
@property (weak, nonatomic) IBOutlet UILabel *volumLabel;
@property (weak, nonatomic) IBOutlet UIView *sliderContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *recordTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong) NSMutableArray  *records;
@property(nonatomic,assign,getter=isRecording) BOOL recording;
@property(nonatomic,strong)  NSTimer * timer  ;

@end

@implementation RCRecordingViewController
-  (NSMutableArray *)records{
    if (!_records) {
        self.records= [NSMutableArray array];

    }
    return _records;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray * newTexts = @[@"",@"无背景",@"恐怖",@"欢乐",@"惊悚",@"抒情",@"幽静"];
        for (NSString * text in newTexts) {
            RCRecord * record = [[RCRecord alloc]init];
            record.text = text;
            [self.records addObject:record];
        }
    }
    return self;
}
-  (RCRecordingInstructionsViewController *)vc{
    if (!_vc) {
        RCRecordingInstructionsViewController * vc = [[RCRecordingInstructionsViewController alloc]init] ;
        vc.delegate = self;
        vc.view.frame = self.view.bounds;
        self.vc = vc;

    }
    return _vc;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[RCBottomPlayerButton playingAudioButton] moveToTop];

}
- (void)viewWillAppear:(BOOL)animated{


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    self.title = @"录音";
    [self addRecognizer];
    [self setUpCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    BOOL usedInstruction = [[[NSUserDefaults standardUserDefaults] valueForKey:@"usedInstruction"] boolValue];
    if (usedInstruction) {
        [self.vc.view removeFromSuperview];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.vc.view];
        [[NSUserDefaults standardUserDefaults ] setValue:@(YES) forKey:@"usedInstruction"];
    }
}
- (void)setUpCollectionView{
    [self.collectionView registerClass:[RCRecordingViewCell class] forCellWithReuseIdentifier:ID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}
-(void)addRecognizer{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panSliderButton:)];
    [self.sliderButton addGestureRecognizer:pan];

}
- (void)didScrollToEnd:(RCRecordingInstructionsViewController *)recordingInstructionsViewController{
    self.vc.view .makeOpacity(0).easeOut.animate(2);
    __weak typeof(self) weakSelf = self;

    self.vc.view.animationCompletion = JHAnimationCompletion(){
        [weakSelf.vc.view removeFromSuperview];
        [weakSelf.vc removeFromParentViewController];

    };
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.records.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RCRecordingViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.record = self.records[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        return;
    }
    RCRecord * record = self.records[indexPath.item];
    for (RCRecord * newRecord  in self.records) {
        newRecord.playing = NO;
    }
    record.playing = YES;
    [self.collectionView reloadData];
}
#pragma mark - 事件处理
#pragma mark  录音

- (IBAction)record:(UIButton *)startOrPausesender {
    if (!self.isRecording) {
        [[AFSoundManager sharedManager] startRecordingAudioWithFileName:@"haha" andExtension:@".wav" shouldStopAtSecond:NO];
        self.recording = YES;
        [self addTimer];
    }else{
        if (startOrPausesender.isSelected) {
            [[AFSoundManager sharedManager] pauseRecording];;
            [self removeTimer];
            self.saveButton.hidden = NO;
            self.resetButton.hidden = NO;
        }else{
            [[AFSoundManager sharedManager] resumeRecording];;
            [self addTimer];
            self.saveButton.hidden = YES;
            self.resetButton.hidden = YES;

        }

    }
    startOrPausesender.selected = !startOrPausesender.isSelected;

}
- (void)addTimer{

    NSTimer * timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changePgogress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)changePgogress{
    NSDate * date =[NSDate dateWithTimeIntervalSinceReferenceDate:[AFSoundManager sharedManager].timeRecorded];
    NSDateFormatter * formtter = [[NSDateFormatter alloc]init];
    formtter.dateFormat = @"mm:ss";
    NSString *dateStr = [formtter stringFromDate:date];
    self.recordTimeLabel.text = dateStr;

}
- (IBAction)saveRecord:(id)sender {
    [[AFSoundManager sharedManager] stopAndSaveRecording];
    self.recordTimeLabel.text = @"00:00";


}
- (IBAction)resetRecord:(id)sender {
        __weak typeof(self) weakSelf = self;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"重录将丢失录音数据，确定要重新录制？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];

    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [[AFSoundManager sharedManager]deleteRecording] ;
        weakSelf.recordTimeLabel.text = @"00:00";
        [[AFSoundManager sharedManager] startRecordingAudioWithFileName:@"bbbb" andExtension:@".wav" shouldStopAtSecond:NO];

        [alertVC dismissViewControllerAnimated:YES completion:^{

        }];
    }];
    [alertVC addAction:cancle];
    [alertVC addAction:ok];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark 滑块

- (void)panSliderButton:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer translationInView:recognizer.view];
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    self.sliderButton.y += point.y;
    if (self.sliderButton.y <= self.sliderContentView.y - self.sliderButton.height) {
        self.sliderButton.y = self.sliderContentView.y - self.sliderButton.height;
    }else if (self.sliderButton.y >= (CGRectGetMaxY(self.sliderContentView.frame)- 25 - self.sliderButton.height)){
        self.sliderButton.y =  (CGRectGetMaxY(self.sliderContentView.frame) - 25 - self.sliderButton.height);
    }
    int bili = ((CGRectGetMaxY(self.sliderContentView.frame) - (self.sliderButton.y +self.sliderButton.height+25))/(self.sliderContentView.height- self.sliderButton.height))*100;
    self.volumLabel.text = [NSString stringWithFormat:@"配乐音量%d%%",bili];
}
@end
