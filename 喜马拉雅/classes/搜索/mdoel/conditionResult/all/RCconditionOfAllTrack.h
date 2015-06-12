//
//  RCconditionOfAllTrack.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCconditionOfAllTrack : NSObject
/**
 *   "numFound": 1045,
 "start": 0,
 "docs": []
 */
@property(nonatomic,strong) NSNumber  *numFound;
@property(nonatomic,strong) NSNumber  *start;
@property(nonatomic,strong) NSArray  *docs;
@end
