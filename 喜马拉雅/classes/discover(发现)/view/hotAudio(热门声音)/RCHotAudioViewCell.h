//
//  RCHotAudioViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCOnneHotAudio.h"
#import "RCTrackList.h"
#import "RCSearchUserInfo.h"
@interface RCHotAudioViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property(nonatomic,strong) RCTrackList  *audio;
@property(nonatomic,strong) RCSearchUserInfo  *searchUserInfo;

@end
