//
//  RCAlbumViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewController.h"
#import "RCCatrgory.h"

@interface RCAlbumViewController : RCBaseViewController
@property(nonatomic,strong) RCCatrgory  *category;
@property(nonatomic,copy) NSString  *tag_name;


@end
