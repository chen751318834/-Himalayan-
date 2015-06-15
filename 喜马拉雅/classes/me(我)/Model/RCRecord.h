//
//  RCRecord.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRecord : NSObject
@property(nonatomic,copy) NSString  *text;
@property(nonatomic,assign,getter=isPlaying) BOOL playing;

@end
