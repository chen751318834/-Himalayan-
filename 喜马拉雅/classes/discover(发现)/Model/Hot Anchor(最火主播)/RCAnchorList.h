//
//  RCAnchorList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAnchorList : NSObject
/**
 *        "id": 0,
 "name": "all",
 "title": "热门",
 "list": []
 */
@property(nonatomic,copy) NSString  *name;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSArray  *list;
@end
