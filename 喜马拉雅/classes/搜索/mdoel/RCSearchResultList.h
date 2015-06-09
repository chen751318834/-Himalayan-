//
//  RCSearchResultList.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSearchResultList : NSObject
/**
 *   "text": "<em>逻辑思维</em>2014-一个该死者的意外生存",
 "id": "4137498",
 "title": "逻辑思维2014-一个该死者的意外生存"
 */
@property(nonatomic,copy) NSString  *text;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,strong) NSNumber  *ID;
@end
