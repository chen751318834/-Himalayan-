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
  [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_downloadAudio(id integer PRAMARY KEY  AUTO INCREMENT,downloadAudio blob NOT NULL,trackId text NOT NULL );"];
}
/**
 *  专辑
 *
 */
+ (void)saveDownloadAlbum:(RCAlbum *)downloadAlbum{
    for (RCAlbum * saveAlbum in [self downloadAlbums]) {
        if ([saveAlbum.albumId isEqual:downloadAlbum.albumId]) {
            //            return;
            [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAlbum WHERE albumId = %@;", downloadAlbum.albumId];

        }
    }

    NSData * albumData = [NSKeyedArchiver
                          archivedDataWithRootObject:downloadAlbum];
    [_db executeUpdateWithFormat:@"INSERT INTO t_downloadAlbum(album ,albumId) VALUES (%@ ,%@)",albumData,downloadAlbum.albumId];
    

}
+ (void)removeDownloadAlbum:(RCAlbum *)downloadAlbum{
    [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAlbum WHERE albumId = %@;", downloadAlbum.albumId];

}
+ (void)removeAllDownloadAlbum{
    for (RCAlbum * album in [self downloadAlbums]) {
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
    
    

}
+ (NSUInteger)downloadAlbumCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAlbum_count FROM t_downloadAlbum;"];
    [set next];
    return [set intForColumn:@"downloadAlbum_count"];
    

}
+ (BOOL)isDownloaddAlbum:(RCAlbum *)downloaddAlbum{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS downloadAlbum_count FROM t_downloadAlbum WHERE albumId = %@;", downloaddAlbum.albumId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"downloadAlbum_count"] == 1;

}
/**
 *  声音
 *
 */
+ (void)saveDownloadAudio:(RCTrackList *)downloadAudio{
    for (RCAlbum * saveAlbum in [self downloadAudios]) {
        if ([saveAlbum.albumId isEqual:downloadAudio.trackId]) {
            //            return;
            [_db executeUpdateWithFormat:@"DELETE FROM t_downloadAudio WHERE trackId = %@;", downloadAudio.trackId];

        }
    }

    NSData * albumData = [NSKeyedArchiver
                          archivedDataWithRootObject:downloadAudio];
    [_db executeUpdateWithFormat:@"INSERT INTO t_downloadAudio(downloadAudio ,trackId) VALUES (%@ ,%@)",albumData,downloadAudio.trackId];
    

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
        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"downloadAudio"]];
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
