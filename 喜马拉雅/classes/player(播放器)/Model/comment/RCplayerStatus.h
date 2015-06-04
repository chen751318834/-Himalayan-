//
//  RCplayerStatus.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/4.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCSingleInstance.h"
@interface RCplayerStatus : NSObject
RCSingleInstanceH(playerStatus);
@property(nonatomic,assign,getter=isPlaying) BOOL playing;
@property(nonatomic,assign,getter=isApplicationEnterBackground) BOOL applicationEnterBackground;

@end
