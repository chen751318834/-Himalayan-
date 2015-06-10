//
//  RCUserAlbum.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserAlbum.h"
#import "MJExtension.h"
#import "RCUserlAudioOrAlbumList.h"
@implementation RCUserAlbum
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[RCUserlAudioOrAlbumList class]};
}
@end
