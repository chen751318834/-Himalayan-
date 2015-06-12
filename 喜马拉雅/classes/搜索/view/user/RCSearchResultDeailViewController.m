//
//  RCSearchResultDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchResultDeailViewController.h"
#import "RCAllConditionViewController.h"
#import "RCAlbumConditionViewController.h"
#import "RCUserConditionViewController.h"
#import "RCVoiceConditionViewController.h"
#import "RCConst.h"
@interface RCSearchResultDeailViewController ()
@property(nonatomic,assign) NSUInteger currentIndex;
@property(nonatomic,strong)  RCAllConditionViewController * allVC;
@end

@implementation RCSearchResultDeailViewController
-(instancetype)init
{
    RCAllConditionViewController * allVC = [[RCAllConditionViewController alloc]init];
    self.allVC = allVC;
    RCAlbumConditionViewController * albumVC = [[RCAlbumConditionViewController alloc]init];
    RCUserConditionViewController * userVC = [[RCUserConditionViewController alloc]init];
    RCVoiceConditionViewController * voiceVC = [[RCVoiceConditionViewController alloc]init];
    self = [super initWithControllers:allVC,albumVC,userVC,voiceVC, nil];
    if (self) {
        self.headerHeight = 0;
        self.segmentMiniTopInset = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
