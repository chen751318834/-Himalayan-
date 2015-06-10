//
//  RCSearchViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
typedef enum {
    RCSearchViewModelDataTypeAll,
    RCSearchViewModelDataTypeAlbum,
    RCSearchViewModelDataTypeuser,
    RCSearchViewModelDataTypeAudio,
}RCSearchViewModelDataType;
@interface RCSearchViewModel : RCBaseViewModel
@property(nonatomic,strong) NSMutableArray  *historySearchTexts;
@property(nonatomic,strong) NSMutableArray  *hotSearchTexts;
- ( void)fetchhotSearchDataWithIndex:(RCSearchViewModelDataType )dataType keywords:(NSString *)keywords success:(void (^)(void ))success failure:(void (^)(void ))failure;
@property(nonatomic,assign) RCSearchViewModelDataType resultDataType;

@end
