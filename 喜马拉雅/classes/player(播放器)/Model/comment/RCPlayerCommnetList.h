//
//  RCPlayerCommnetList.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCPlayerCommnetList : NSObject
/**
 *         "id": 10784653,
 "track_id": 7134464,
 "uid": 27774439,
 "nickname": "安鑫二手车",
 "smallHeader": "http://wx.qlogo.cn/mmopen/B93frgW0kDM8Cny3zTaUabDiaThETpiaDsaQxZPm1t6hUrckRwjdRlAxoib4tLD4b4egD62qnF11vvvVX5hqszhiazkENjspROul/0",
 "content": "[嘻嘻]",
 "createdAt": 1433298589000,
 "parentId": 10784653
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *track_id;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *parentId;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallHeader;
@property(nonatomic,copy) NSString  *content;
@property(nonatomic,copy) NSAttributedString  *AttributedContent;

@property(nonatomic,copy) NSString  *createTime;
@property(nonatomic,strong) NSNumber* follor;
@end
