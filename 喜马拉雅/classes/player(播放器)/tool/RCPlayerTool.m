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
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_playedAudio(id integer PRAMARY KEY  AUTO INCREMENT,playedAudio blob NOT NULL,trackId text NOT NULL );"];

}
+ (NSArray *)playedAudios{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT playedAudio FROM t_playedAudio ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * playedAudios = [NSMutableArray array];
    while (set.next) {
        RCPlaylist * playedAudio = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"playedAudio"]];
        [playedAudios addObject:playedAudio];
    }
    return playedAudios;
    
    
}
+ (void)savePlayedAudio:(RCPlaylist *)playedAudio{
    for (RCPlaylist * savePlayedAudio in [self playedAudios]) {
        if ([savePlayedAudio.trackId isEqual:playedAudio.trackId]) {
            [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE trackId = %@;", playedAudio.trackId];
        }
    }

    NSData * playedAudioData = [NSKeyedArchiver
                          archivedDataWithRootObject:playedAudio];

        [_db executeUpdateWithFormat:@"INSERT INTO t_playedAudio(playedAudio ,trackId) VALUES (%@ ,%@)",playedAudioData,playedAudio.trackId];


}
+ (void)removePlayedAudio:(RCPlaylist *)playedAudio{
    [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE playedAudioId = %@;", playedAudio.trackId];

}
+ (void)removeAllPlayedAudio{
    for (RCPlaylist * playedAudio in [self playedAudios]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_playedAudio WHERE trackId = %@;", playedAudio.trackId];
    }
}
+ (NSArray *)playedAudiosWithPage:(NSUInteger)page{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT playedAudio FROM t_playedAudio ORDER BY rowid DESC LIMIT %d , %d;",(int)page*10,10];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * playedAudios = [NSMutableArray array];
    while (set.next) {
        RCPlaylist * playedAudio = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"playedAudio"]];
        [playedAudios addObject:playedAudio];

    }
    return playedAudios;
}
+ (NSUInteger)playedAudioCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS playedAudio_count FROM t_playedAudio;"];
    [set next];
    return [set intForColumn:@"playedAudio_count"];
}
+ (BOOL)isCollectPlayedAudio:(RCPlaylist *)playedAudio{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS playedAudio_count FROM t_playedAudio WHERE trackId = %@;", playedAudio.trackId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"playedAudio_count"] == 1;
}
@end
