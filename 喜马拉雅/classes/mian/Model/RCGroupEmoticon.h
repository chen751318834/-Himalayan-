//
//  RCGroupEmoticon.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCGroupEmoticon : NSObject
@property(nonatomic,copy) NSString  *emoticon_group_name;
@property(nonatomic,copy) NSString  *emoticon_group_name_en;
@property(nonatomic,copy) NSString  *emoticon_group_name_tw;
@property(nonatomic,copy) NSString  *emoticon_group_type;
@property(nonatomic,copy) NSString  *emoticon_group_name_cn;
@property(nonatomic,strong) NSArray  *emoticon_group_emoticons;
@end
