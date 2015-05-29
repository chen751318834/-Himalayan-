//
//  RCCollectViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCollectViewModel.h"
#import <UIKit/UIKit.h>
#import "RCAlbumTool.h"
@interface RCCollectViewModel ()
@property(nonatomic,assign) NSUInteger currentPage;
@end
@implementation RCCollectViewModel
RCSingleInstanceM(collectViewModel);
-  (NSMutableArray *)saveAlbumlists{
    if (!_saveAlbumlists) {
        self.saveAlbumlists = [NSMutableArray array];

    }
    return _saveAlbumlists;
}
- (NSUInteger)albumCount{

    return [RCAlbumTool albumCount];
}
- (void)loadNewAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {
    [self.saveAlbumlists addObjectsFromArray:[RCAlbumTool albumsWithPage:self.currentPage]];
    if (success) {
        success();
    }
    

}
- (void)loadMoreAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currentPage ++;
    [self.saveAlbumlists addObjectsFromArray:[RCAlbumTool albumsWithPage:self.currentPage]];
    if (success) {
        success();
    }

}
- (NSInteger)numberOfRowAlbumlistInSection: (NSInteger)section{
    return self.saveAlbumlists.count;
}
- (RCAlbum *)AlbumListAtIndexPath: (NSIndexPath *)indexPath{
    return self.saveAlbumlists[indexPath.row];
}
@end
