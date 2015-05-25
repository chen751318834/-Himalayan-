//
//  RCAlbumDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDeailViewController.h"
#import "CSCell.h"
#import "CSStickyHeaderFlowLayout.h"
@interface RCAlbumDeailViewController ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation RCAlbumDeailViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *statusBarView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    statusBarView.image = [UIImage imageNamed:@"albumStatusbg"];

    [self.view addSubview:statusBarView];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.sections = @[
                      @[
                          @"Song 1",
                          @"Song 2",
                          @"Song 3",
                          @"Song 4",
                          @"Song 5",
                          @"Song 6",
                          @"Song 7",
                          @"Song 8",
                          @"Song 9",
                          @"Song 10",
                          @"Song 11",
                          @"Song 12",
                          @"Song 13",
                          @"Song 14",
                          @"Song 15",
                          @"Song 16",
                          @"Song 17",
                          @"Song 18",
                          @"Song 19",
                          @"Song 20",
                          ],
                      ];



    // Also insets the scroll indicator so it appears below the search bar
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    [self.collectionView registerNib:[UINib nibWithNibName:@"RCAlbumHeaderView" bundle:nil]
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CSCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];

}
- (instancetype)init
{
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];

    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 426);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 92);
        layout.parallaxHeaderAlwaysOnTop = YES;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
    }

    return [super initWithCollectionViewLayout:layout];
}
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sections[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *obj = self.sections[indexPath.section][indexPath.row];

    CSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                             forIndexPath:indexPath];

    cell.contentLabel.text = obj;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
 if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        UICollectionReusableView *cell = [collectionView
        dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];

        return cell;
    }
    return nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
