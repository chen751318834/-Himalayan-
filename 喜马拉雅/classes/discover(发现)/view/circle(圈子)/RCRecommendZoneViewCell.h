//
//  RCRecommendZoneViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCRecommendedZones.h"
@interface RCRecommendZoneViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *joinButon;

@property(nonatomic,strong) RCRecommendedZones  *zone;
@end
