//
//  RCSearchBar.m
//  微博
//
//  Created by Raychen on 14/12/15.
//  Copyright (c) 2014年 raychen. All rights reserved.
//

#import "RCSearchBar.h"
#import "UIImage+RC.h"



@interface RCSearchBar ()
@end
@implementation RCSearchBar
+ (instancetype)searchBar{

    return [[self alloc]init];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //设置左边的view
        UIImageView *leftSearchView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_btn_nl"]];
        leftSearchView.contentMode =UIViewContentModeCenter;
        self.leftViewMode =UITextFieldViewModeAlways;
        self.leftView =leftSearchView;
        //背景
        self.background =[UIImage resizableImage:@"search_header_bg"];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        //设置占位文字的颜色和字体大小
        NSDictionary *dict =[NSDictionary dictionary];
        
        dict =@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13],};
        self.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"" attributes:dict];

        
        //清除按钮
        self.clearButtonMode =UITextFieldViewModeAlways;
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftView.frame =CGRectMake(0, 0, 30,self.frame.size.height);

}
@end
