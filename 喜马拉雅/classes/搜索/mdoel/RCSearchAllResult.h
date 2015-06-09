//
//  RCSearchAllResult.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCSearchSoundResult.h"
#import "RCSearchAlbumResult.h"
#import "RCSearchUserResult.h"
@interface RCSearchAllResult : NSObject
/**
 *   "scope": "all",
 "sound": {},
 "album": {},
 "user": {}
 */
@property(nonatomic,copy) NSString  *all;
@property(nonatomic,strong) RCSearchSoundResult  *sound;
@property(nonatomic,strong) RCSearchAlbumResult  *album;
@property(nonatomic,strong) RCSearchUserResult  *user;

@end
