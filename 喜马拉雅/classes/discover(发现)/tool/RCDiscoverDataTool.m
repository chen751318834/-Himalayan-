//
//  RCDiscoverDataTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCDiscoverDataTool.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
#import "RCCategoryFocusImageParam.h"
#import "RCCategoryFocusImageResult.h"
#import "RCCategryListParam.h"
#import "RCCategoryListResult.h"
#import "FMDatabase.h"
#import "RCList.h"
@implementation RCDiscoverDataTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"discvoerData.sqlite"];
    _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_recommendAlbum(id integer PRAMARY KEY  AUTO INCREMENT,recommendAlbum blob NOT NULL,trackId text NOT NULL );"];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_focusImage(id integer PRAMARY KEY  AUTO INCREMENT,focusImage blob NOT NULL,trackId text NOT NULL );"];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_discoverData(id integer PRAMARY KEY  AUTO INCREMENT,discoverData blob NOT NULL );"];

}
+ (RCDiscoverData *)discoverData{
    NSString * sql = nil;
    sql =[NSString stringWithFormat: @"SELECT discoverData FROM t_discoverData ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    RCDiscoverData * discoverData = nil;
    if (set.next) {
        discoverData = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"discoverData"]];
    }
    return discoverData;

}
+ (void)saveDiscoverData:(RCDiscoverData *)discoverData{
        [_db executeUpdateWithFormat:@"DELETE FROM t_discoverData WHERE rowid = %@;",@(1)];

        NSData * listData = [NSKeyedArchiver
                             archivedDataWithRootObject:discoverData];
        [_db executeUpdateWithFormat:@"INSERT INTO t_discoverData(discoverData ) VALUES (%@ )",listData];

}
+ (NSArray *)focusImages{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT focusImage FROM t_focusImage ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * playedAudios = [NSMutableArray array];
    while (set.next) {
        RCList * imageList = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"focusImage"]];
        [playedAudios addObject:imageList];
    }
    return playedAudios;

}
+ (NSArray *)recommendAlbums{

    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT recommendAlbum FROM t_recommendAlbum ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * recommentAlbumLists = [NSMutableArray array];
    while (set.next) {
        RCList * recommentAlbumList = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"recommendAlbum"]];
        [recommentAlbumLists addObject:recommentAlbumList];
    }
    return recommentAlbumLists;
    

}
+ (void)saveFocusImages:(NSArray *)focusImages{
    for (RCList * list in [self focusImages]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_focusImage WHERE trackId = %@;", list.trackId];
    }
    for (RCList * list in focusImages) {
        NSData * listData = [NSKeyedArchiver
                                    archivedDataWithRootObject:list];
        [_db executeUpdateWithFormat:@"INSERT INTO t_focusImage(focusImage ,trackId) VALUES (%@ ,%@)",listData,list.trackId];
    }
}
+ (void)saveRecommendAlbums:(NSArray *)recommendAlbums{
    for (RCList * list in [self recommendAlbums]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_recommendAlbum WHERE trackId = %@;", list.ID];
    }
    for (RCList * list in recommendAlbums) {
        NSData * listData = [NSKeyedArchiver
                             archivedDataWithRootObject:list];
        [_db executeUpdateWithFormat:@"INSERT INTO t_recommendAlbum(recommendAlbum ,trackId) VALUES (%@ ,%@)",listData,list.ID];
        
    }
}
+ (void)categoryListWithParam:(RCCategryListParam *)param success:(void (^)(RCCategoryListResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/category_tag_list" params:param.keyValues success:^(id json) {
        RCCategoryListResult * result = [RCCategoryListResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)categoryFocusImageWithParam:(RCCategoryFocusImageParam *)param success:(void (^)(RCCategoryFocusImageResult *))success failure:(void (^)(NSError *))failure{

    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/category_focus_image" params:param.keyValues success:^(id json) {
        RCCategoryFocusImageResult * result = [RCCategoryFocusImageResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end


