//
//  RCAlbumTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumTool.h"
#import "FMDatabase.h"
@implementation RCAlbumTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"albums.sqlite"];
    _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_album(id integer PRAMARY KEY  AUTO INCREMENT,album blob NOT NULL,albumId text NOT NULL );"];

}

+ (NSArray *)albums{
    NSString * sql = nil;

    sql =[NSString stringWithFormat: @"SELECT album FROM t_album ORDER BY rowid DESC "];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {
        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"album"]];
        [albums addObject:album];
    }
    return albums;


}
+ (void)saveAlbum:(RCAlbum *)album{
    for (RCAlbum * saveAlbum in [self albums]) {
        if ([saveAlbum.albumId isEqual:album.albumId]) {
            //            return;
            [_db executeUpdateWithFormat:@"DELETE FROM t_album WHERE albumId = %@;", album.albumId];

        }
    }

    NSData * albumData = [NSKeyedArchiver
                          archivedDataWithRootObject:album];
    [_db executeUpdateWithFormat:@"INSERT INTO t_album(album ,albumId) VALUES (%@ ,%@)",albumData,album.albumId];

}
+ (void)removealbum:(RCAlbum *)album{
    [_db executeUpdateWithFormat:@"DELETE FROM t_album WHERE albumId = %@;", album.albumId];

}
+ (NSArray *)albumsWithPage:(NSUInteger )page{
    NSString * sql = nil;
    //0 -20
    //20- 40
    //40 - 60
    sql =[NSString stringWithFormat: @"SELECT album FROM t_album ORDER BY rowid DESC LIMIT %ld , %d;",page* 10,10];

    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * albums = [NSMutableArray array];
    while (set.next) {

        RCAlbum * album = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"album"]];
        [albums addObject:album];

    }
    return albums;
}
+ (void)removeAllAlbum{
    for (RCAlbum * album in [self albums]) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_album WHERE albumId = %@;", album.albumId];
    }
}
+ (NSUInteger)albumCount{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS album_count FROM t_album;"];
    [set next];
    return [set intForColumn:@"album_count"];

}
//+ (RCAlbum *)album{
//
//    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT album  FROM t_album WHERE albumId = %@;"];
//    [set next];
//}
+ (BOOL)isCollectAlbum:(RCAlbum *)album{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS album_count FROM t_album WHERE albumId = %@;", album.albumId];
    [set next];
    //#warning 索引从1开始
    return [set intForColumn:@"album_count"] == 1;
}
@end
