//
//  RCConditionAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCConditionResponseHeader.h"
#import "RCConditionResponse.h"
#import "RCConditionHighlighting.h"
@interface RCConditionAlbum : NSObject
/**
 *      "responseHeader": {},
 RCConditionAlbumHighlighting
 "RCConditionAlbumHighlighting": {},
 "highlighting": {}
 */
@property(nonatomic,strong) RCConditionResponseHeader  *responseHeader;
@property(nonatomic,strong) RCConditionResponse  *response;
@property(nonatomic,strong) RCConditionHighlighting  *highlighting;
@end
