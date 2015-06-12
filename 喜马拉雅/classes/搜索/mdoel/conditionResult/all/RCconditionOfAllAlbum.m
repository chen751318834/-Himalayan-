//
//  RCconditionOfAllAlbum.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCconditionOfAllAlbum.h"
#import "RCconditionOfAllAlbumDoc.h"
#import "MJExtension.h"
@implementation RCconditionOfAllAlbum
+ (NSDictionary *)objectClassInArray{
    return @{@"docs":[RCconditionOfAllAlbumDoc class]};
}
@end
