//
//  RCConditionResponseHeaderParam.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCConditionResponseHeaderParam : NSObject
/**
 *    "sort": "album_relation desc",
 "start": "0",
 "q": " '青雪故事'",
 "qf": "category_title^100 title^80 tags^50 intro^0.001",
 "searchMessage": "{\"domain\":2,\"uid\":0,\"keyword\":\"青雪故事\",\"uuid\":\"ac771c6f96f04cb5b60494bce42515c9\",\"time\":\"20150612150653000\",\"from\":\"mobile\"}",
 "wt": "json",
 "fq": "",
 "defType": "edismax",
 "rows": "20"
 }
 */
@property(nonatomic,copy) NSString  *sort;
@property(nonatomic,copy) NSString  *start;
@property(nonatomic,copy) NSString  *q;
@property(nonatomic,copy) NSString  *qf;
@property(nonatomic,copy) NSString  *searchMessage;
@property(nonatomic,copy) NSString  *wt;
@property(nonatomic,copy) NSString  *fq;
@property(nonatomic,copy) NSString  *rows;
@property(nonatomic,copy) NSString  *defType;

@end
