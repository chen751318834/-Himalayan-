//
//  RCAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAlbum : NSObject
/**
 *  "id": 321705,
 "title": "今晚80后脱口秀 2015",
 "albumCoverUrl290": "http://fdfs.xmcdn.com/group12/M00/09/7A/wKgDW1VfCQjwLbK8AAGaZRNRrII383_mobile_large.jpg",
 "lastUptrackAt": 1432447947000,
 "playsCounts": 13012836,
 "tracksCounts": 29,
 "serialState": 0
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *lastUptrackAt;
@property(nonatomic,strong) NSNumber  *playsCounts;
@property(nonatomic,strong) NSNumber  *tracksCounts;
@property(nonatomic,strong) NSNumber  *serialState;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *albumCoverUrl290;
@property(nonatomic,copy) NSString  *updateTime;

@property(nonatomic,assign,getter=isCollect) BOOL collect;


@end
