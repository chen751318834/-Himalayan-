//
//  RCOneComment.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCRecommendPoster.h"
@interface RCOneComment : NSObject
/**
 *          "id": 1400,
 "createdTime": 1416989713000,
 "updatedTime": 1416989713000,
 "content": "既然工作稳定，楼主还是不要轻易辞职，女人一定要有一份能养得起自己的工作，等你只会围着家庭转了，家庭也很容易出问题。既然不差钱，就请个保姆吧！",
 "numOfFloor": 1,
 "canBeDeleted": false,
 "postId": 1398,
 "timeline": 25974959768952,
 "images": [ ],
 "poster": {}
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *createdTime;
@property(nonatomic,strong) NSNumber  *updatedTime;
@property(nonatomic,strong) NSNumber  *numOfFloor;
@property(nonatomic,strong) NSNumber  *postId;
@property(nonatomic,strong) NSNumber  *timeline;
@property(nonatomic,copy) NSString  *content;
@property(nonatomic,strong) NSArray  *images;
@property(nonatomic,assign) BOOL canBeDeleted;
@property(nonatomic,strong) RCRecommendPoster  *poster;
@end
