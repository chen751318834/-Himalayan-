//
//  RCCategoryList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCategoryList : NSObject
/**
 *   "category_id": null,
 "tname": "郭德纲相声",
 "cover_path": "http://fdfs.xmcdn.com/group3/M03/65/0E/wKgDslJ7CNqAL3AOAAAeUWi2sBo762.jpg"
 */
@property(nonatomic,copy) NSString  *category_id;
@property(nonatomic,copy) NSString  *tname;
@property(nonatomic,copy) NSString  *cover_path;

@end
