//
//  RCconditionAll.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCconditionOfAllTrack.h"
#import "RCconditionOfAllAlbum.h"
#import "RCconditionOfAllUser.h"
@interface RCconditionAll : NSObject
/**
 *      "track": {},
 "album": {},
 "user": {}
 */
@property(nonatomic,strong) RCconditionOfAllTrack  *track;
@property(nonatomic,strong) RCconditionOfAllAlbum  *album;
@property(nonatomic,strong) RCconditionOfAllUser  *user;
@end
