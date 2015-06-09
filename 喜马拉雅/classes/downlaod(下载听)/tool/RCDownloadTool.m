//
//  RCDownloadTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadTool.h"
#import "FMDatabase.h"

@implementation RCDownloadTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"downloadAlbums.sqlite"];
    _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_downloadAlbum(id integer PRAMARY KEY  AUTO INCREMENT,downloadAlbum blob NOT NULL,albumId text NOT NULL );"];
  [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_downloadAudio(id integer PRAMARY KEY  AUTO INCREMENT,downloadAudio blob NOT NULL,trackId text NOT NULL,albumId text NOT NULL );"];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_downloadingAudio(id integer PRAMARY KEY  AUTO INCREMENT,downloadingAudio blob NOT NULL,trackId text NOT NULL );"];

}
/**
 *  正在下载的声音
 *
 */
+ (void)saveDownloadingAudio:(RCTrackList *)downloadingAudio{
    for (RCTrackList * saveDownloadingAudio in [self downloadingAudios]) {
        if ([downloadingAudio.trackId isEqualToNumber:saveDownloadingAudio.trackId]) {
            [_db executeUpdateWithFormat:@"DELETE FROM t_downloadingAudio WHERE trackId = %@;", downloadingAudio.trackId];

        }
    }

    NSData * downloadAudioData = [NSKeyedArchiver
                                  archivedDataWithRootObject:downloadingAudio];
    [_db executeUpdateWithFormat:@"INSERT INTO t_downloadingAudio(downloadingAudio,trackId) VALUES (%@,%@)",downloadAudioData,downloadingAudio.trackId];


}
+ (void)removeDownloadingAudio:(RCTrackList *)downloadingAudio{
    [_db executeUpdateWithFormat:@"DELETE FROM t_downloadingAudio WHERE trackId = %@;", downloadingAudio.trackId];

}
+ (void)removeAllDownloadingAudio{
    for (RCTrackList * album in [self downloadingAudios]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_downloadingAudio WHERE trackId = %@;", album.trackId];
    }
}
+ (NSArray *)downloadingAudios{
    NSString * sql = nil;
    sql =[NSString stringWithFormat: @"SELECT downloadingAudio FROM t_downloadingAudio ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {
        RCTrackList * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadingAudio"]];
        [albums addObject:album];
    }
    return albums;

}
+ (NSUInteger)downloadingAudioCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadingAudio_count FROM t_downloadingAudio;"];
    [set next];
    return [set intForColumn:@"downloadingAudio_count"];
}
+ (BOOL)isDownloadingAudio:(RCTrackList *)downloadingAudio{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadingAudio_count FROM t_downloadingAudio WHERE trackId = %@;", downloadingAudio.trackId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"downloadingAudio_count"] == 1;

}
/**
 *  专辑
 *
 */
+ (void)saveDownloadAlbum:(RCTrackList *)downloadAlbum{
    for (RCTrackList * saveAlbum in [self downloadAlbums]) {
        if ([saveAlbum.albumId isEqualToNumber:downloadAlbum.albumId]) {
            [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAlbum WHERE albumId = %@;", downloadAlbum.albumId];

        }
    }

    NSData * albumData = [NSKeyedArchiver
                          archivedDataWithRootObject:downloadAlbum];
    [_db executeUpdateWithFormat:@"INSERT INTO t_downloadAlbum(downloadAlbum ,albumId) VALUES (%@ ,%@)",albumData,downloadAlbum.albumId];
    

}
+ (void)removeDownloadAlbum:(RCTrackList *)downloadAlbum{
    [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAlbum WHERE albumId = %@;", downloadAlbum.albumId];

}
+ (void)removeAllDownloadAlbum{
    for (RCTrackList * album in [self downloadAlbums]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAlbum WHERE albumId = %@;", album.albumId];
    }

}
+ (NSArray *)downloadAlbumsWithPage:(NSUInteger )page{

    NSString * sql = nil;
    //0 -20
    //20- 40
    //40 - 60
    sql =[NSString stringWithFormat: @"SELECT downloadAlbum FROM t_downloadAlbum ORDER BY rowid DESC LIMIT %ld , %d;",page* 10,10];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {

        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadAlbum"]];
        [albums addObject:album];

    }
    return albums;

}
+ (NSArray *)downloadAlbums{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT downloadAlbum FROM t_downloadAlbum ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {
        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadAlbum"]];
        [albums addObject:album];
    }
    return albums;
//    NSMutableArray * albums = [NSMutableArray array];
//    NSArray * audios = [self downloadAudios];
//    for (int i = 0; i<audios.count; i++) {
//        if ([albums  containsObject:[audios objectAtIndex:i]] == NO ) {
//            [albums addObject:[audios objectAtIndex:i]];
//        }
//    }
//
//    return albums;


}
+ (NSUInteger)downloadAlbumCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAlbum_count FROM t_downloadAlbum;"];
    [set next];
    return [set intForColumn:@"downloadAlbum_count"];

//    return [self downloadAudioCount];
}
//+ (BOOL)isDownloaddAlbum:(RCAlbum *)downloaddAlbum{
//    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAlbum_count FROM t_downloadAlbum WHERE albumId = %@;", downloaddAlbum.albumId];
//    [set next];
//    //#warning 索引从1开始
//    return [set intForColumn:@"downloadAlbum_count"] == 1;
//
//}

+ (NSArray *)downloadAudiosWithAlbumId:(NSNumber *)albumId{
    NSMutableArray * albums =  [NSMutableArray array];
    for (RCTrackList *list in [self downloadAudios]) {
        if ([albumId isEqualToNumber:list.albumId]) {
            [albums addObject:list];
        }
    }
    return albums;
}
/**
 *  声音
 *
 */
+ (void)saveDownloadAudio:(RCTrackList *)downloadAudio{
    for (RCTrackList * saveDownloadAudio in [self downloadAudios]) {
        if ([downloadAudio.trackId isEqualToNumber:saveDownloadAudio.trackId]) {
            [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAudio WHERE trackId = %@;", downloadAudio.trackId];

        }
    }

    NSData * downloadAudioData = [NSKeyedArchiver
                          archivedDataWithRootObject:downloadAudio];
    [_db executeUpdateWithFormat:@"INSERT INTO t_downloadAudio(downloadAudio,trackId,albumId) VALUES (%@,%@,%@)",downloadAudioData,downloadAudio.trackId,downloadAudio.albumId];
    

}
+ (void)removeDownloadAudio:(RCTrackList *)downloadAudio{
    [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAudio WHERE trackId = %@;", downloadAudio.trackId];

}
+ (void)removeAllDownloadAudio{

    for (RCTrackList * album in [self downloadAudios]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAudio WHERE trackId = %@;", album.trackId];
    }

}
+ (NSArray *)downloadAudiosWithPage:(NSUInteger )page{
    NSString * sql = nil;
    //0 -20
    //20- 40
    //40 - 60
    sql =[NSString stringWithFormat: @"SELECT downloadAudio FROM t_downloadAudio ORDER BY rowid DESC LIMIT %ld , %d;",page* 10,10];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {

        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadAudio"]];
        [albums addObject:album];

    }
    return albums;

}
+ (NSArray *)downloadAudios{
    NSString * sql = nil;
    sql =[NSString stringWithFormat: @"SELECT downloadAudio FROM t_downloadAudio ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {
        RCTrackList * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadAudio"]];
        [albums addObject:album];
    }
    return albums;
}
+ (NSUInteger)downloadAudioCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAudio_count FROM t_downloadAudio;"];
    [set next];
    return [set intForColumn:@"downloadAudio_count"];
}
+ (BOOL)isDownloadAudio:(RCTrackList *)downloadAudio{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAudio_count FROM t_downloadAudio WHERE trackId = %@;", downloadAudio.trackId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"downloadAudio_count"] == 1;

}

@end
