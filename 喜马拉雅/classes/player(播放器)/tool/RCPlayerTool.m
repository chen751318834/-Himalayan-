//
//  RCPlayerTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//
#import "RCPlayerTool.h"
#import "FMDatabase.h"
@implementation RCPlayerTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"audios.sqlite"];
    _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_playedAudio(id integer PRAMARY KEY  AUTO INCREMENT,playedAudio blob NOT NULL,albumId text NOT NULL );"];

}
+ (NSArray *)playedAudios{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT playedAudio FROM t_playedAudio ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * playedAudios = [NSMutableArray array];
    while (set.next) {
        RCPlayerInfo * playedAudio = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"playedAudio"]];
        [playedAudios addObject:playedAudio];
    }
    return playedAudios;
    
    
}
+ (void)savePlayedAudio:(RCPlayerInfo *)playedAudio{
    for (RCPlayerInfo * savePlayedAudio in [self playedAudios]) {
        if ([savePlayedAudio.albumId isEqual:playedAudio.albumId]) {
            //            return;
            [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE albumId = %@;", playedAudio.albumId];

        }
    }

    NSData * playedAudioData = [NSKeyedArchiver
                          archivedDataWithRootObject:playedAudio];
    [_db executeUpdateWithFormat:@"INSERT INTO t_playedAudio(playedAudio ,albumId) VALUES (%@ ,%@)",playedAudioData,playedAudio.albumId];

}
+ (void)removePlayedAudio:(RCPlayerInfo *)playedAudio{
    [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE playedAudioId = %@;", playedAudio.albumId];

}
+ (void)removeAllPlayedAudio{
    for (RCPlayerInfo * playedAudio in [self playedAudios]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE albumId = %@;", playedAudio.albumId];
    }
}
+ (NSArray *)playedAudiosWithPage:(NSUInteger)page{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT playedAudio FROM t_playedAudio ORDER BY rowid DESC LIMIT %d , %d;",(int)page*10,10];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * playedAudios = [NSMutableArray array];
    while (set.next) {
        RCPlayerInfo * playedAudio = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"playedAudio"]];
        [playedAudios addObject:playedAudio];

    }
    return playedAudios;
}
+ (NSUInteger)playedAudioCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS playedAudio_count FROM t_playedAudio;"];
    [set next];
    return [set intForColumn:@"playedAudio_count"];
}
+ (BOOL)isCollectPlayedAudio:(RCPlayerInfo *)playedAudio{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS playedAudio_count FROM t_playedAudio WHERE albumId = %@;", playedAudio.albumId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"playedAudio_count"] == 1;
}
@end
