//
//  RCSearchConditionViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
#import "RCconditionOfAllTrack.h"
#import "RCconditionOfAllAlbum.h"
#import "RCconditionOfAllUser.h"


typedef enum {
    albumDataTypeInvolve,//最相关
    albumDataTypeRecent,//最近上传
    albumDataTypePaly//最多播放
}albumDataType;
;

typedef enum {
    userDataTypeInvolve,//相关度
    userDataTypeRecent,//最近粉丝
    userDataTypePaly//最多声音
}userDataType;


typedef enum {
    voiceDataTypeInvolve,//最相关
    voiceDataTypeRecent,//最近上传
    voiceDataTypePaly//最多播放
}voiceDataType;

@interface RCSearchConditionViewModel : RCBaseViewModel
@property(nonatomic,strong) NSMutableArray  *albums;
@property(nonatomic,strong) NSMutableArray  *users;
@property(nonatomic,strong) NSMutableArray  *tracks;
@property(nonatomic,strong) RCconditionOfAllTrack  *track;
@property(nonatomic,strong) RCconditionOfAllAlbum  *album ;
@property(nonatomic,strong) RCconditionOfAllUser  *user;
@property(nonatomic,strong) NSMutableArray  *responseDocs;
@property(nonatomic,strong) NSMutableArray  *responseUserDocs;
@property(nonatomic,strong) NSMutableArray  *responseVoiceDocs;

/**
 *  所有
 *
 */
- ( void)fetchNewAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
/**
 *  找专辑
 *
 */

- ( void)fetchNewAlbumWithDataType:(albumDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreAlbumWithDataType:(albumDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

/**
 *  找人
 *
 */
- ( void)fetchNewUserWithDataType:(userDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreUserWithDataType:(userDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
/**
 *  找声音
 *
 */
- ( void)fetchNewVoiceWithDataType:(voiceDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreVoiceWithDataType:(voiceDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
@end
