//
//  RCMeHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCMeHeaderView.h"
#import "RCRecordingInstructionsViewController.h"
#import "RCNavigationController.h"
#import "RCRecordingViewController.h"
#import "UIImage+RC.h"
@interface RCMeHeaderView () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *largeIconView;
@property (weak, nonatomic) IBOutlet UIImageView *avataIconVIew;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property (weak, nonatomic) IBOutlet UIButton *albumButton;
@end
@implementation RCMeHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCMeHeaderView" owner:nil options:nil ]lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPhotoAlbum)];
    [self.avataIconVIew addGestureRecognizer:tap];
    self.avataIconVIew.image = [UIImage circleImageWithName:@"find_radio_default" borderWidth:0 borderColor:nil];
    [self setUpButton:self.careButton count:10  title:[NSString stringWithFormat:@"%d\n关注",10]];
    [self setUpButton:self.audioButton count:10  title:[NSString stringWithFormat:@"%d\n声音",10]];
    [self setUpButton:self.albumButton count:10  title:[NSString stringWithFormat:@"%d\n专辑",10]];
    [self setUpButton:self.fansButton count:200  title:[NSString stringWithFormat:@"%d\n粉丝",200]];

}
- (void)setUpButton:(UIButton *)button  count:(int )count  title:(NSString *)title{

    button.titleLabel.numberOfLines = 0;
    NSMutableDictionary * attr = [NSMutableDictionary dictionary];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:title attributes:attr];
    NSRange range = [title rangeOfString:[NSString stringWithFormat:@"%d",count]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range
     ];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range
     ];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(range.length+1 ,   title.length - range.length - 1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor]range:NSMakeRange(range.length+1 ,   title.length - range.length - 1)];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;

    [button setAttributedTitle:attrString forState:UIControlStateNormal];
    
    
}
- (void)openPhotoAlbum{
    UIImagePickerController * imageVC = [[UIImagePickerController alloc]init];
    imageVC.delegate = self;
    [[RCNavigationController navigationController] presentViewController:imageVC animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)record:(id)sender {
//    RCRecordingInstructionsViewController * userRecordVC = [[RCRecordingInstructionsViewController alloc]init];
    RCRecordingViewController * recordVC = [[RCRecordingViewController alloc]init];
//    BOOL usedInstruction = [[[NSUserDefaults standardUserDefaults] valueForKey:@"usedInstructions"] boolValue];
//    if (usedInstruction) {
        [[RCNavigationController navigationController] pushViewController:recordVC animated:YES];
//    }else{
//        [[RCNavigationController navigationController] pushViewController:userRecordVC animated:YES];
//
////    }
}


@end
