//
//  RCSearchTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchTool.h"
#import "FMDatabase.h"
@implementation RCSearchTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchHistory.sqlite"];
    _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_searchHistory(id integer PRAMARY KEY  AUTO INCREMENT,searchHistory blob NOT NULL,SearchID text NOT NULL );"];


}
+ (void)saveSearchHistory:(RCSearchResultList *)searchHistory{
    [_db executeUpdateWithFormat:@"DELETE FROM t_searchHistory WHERE SearchID = %@;",searchHistory.ID];

    NSData * searchHistoryData = [NSKeyedArchiver
                         archivedDataWithRootObject:searchHistory];
    [_db executeUpdateWithFormat:@"INSERT INTO t_searchHistory(searchHistory,SearchID) VALUES (%@ , %@)",searchHistoryData,searchHistory.ID];


}
+ (void)removeAllSearchHistory{
    for (RCSearchResultList * searchHistory in [self searchHistorys]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_searchHistory WHERE SearchID = %@;", searchHistory.ID];
    }

}
+ (NSArray *)searchHistorys{
    NSString * sql = nil;
    sql =[NSString stringWithFormat: @"SELECT searchHistory FROM t_searchHistory ORDER BY rowid DESC "];
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * historys = [NSMutableArray array];
    while (set.next) {
        RCSearchResultList * searchHistory = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"searchHistory"]];
        [historys addObject:searchHistory];
    }
    return historys;

}

@end
