//
//  RCAlbumTrack.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RCOneAlbum.h"
#import "RCAlbum.h"
#import "RCTrack.h"
@interface RCAlbumTrack : NSObject
/**
 *      "ret": 0,
 "album": {},
 "tracks": {},
 "msg": "0"
 */
@property(nonatomic,strong) NSNumber  *ret;
@property(nonatomic,strong) NSNumber  *msg;
@property(nonatomic,strong) RCAlbum  *album;
@property(nonatomic,strong) RCTrack  *tracks;
@end
