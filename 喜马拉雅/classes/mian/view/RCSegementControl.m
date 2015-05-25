//
//  RCSegementControl.m
//  QQZone
//
//  Created by Raychen on 14/12/28.
//  Copyright (c) 2014年 raychen. All rights reserved.
//

#import "RCSegementControl.h"
#import "UIView+Extension.h"
#import "SegementButton.h"
#import "UIImage+RC.h"



@interface RCSegementControl ()
@property(nonatomic,weak) SegementButton * selectedButton;
@end
@implementation RCSegementControl
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
    }
    
    return self;
    
    
}
- (void)setItems:(NSArray *)items{
    _items =items;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int count = items.count;
    for (int i =0; i<count; i++) {
        SegementButton *button =[[SegementButton alloc]init];
        button.tag = i ;
                [button setTitle:items[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        NSString *bgName;
        if (i ==0) {
            bgName =@"SegmentedControl_Left_Normal";
        }else if (i ==count -1){
            bgName =@"SegmentedControl_Right_Normal";
        }else{
            bgName =@"SegmentedControl_Normal";
        }
        
        [button setBackgroundImage:[UIImage resizableImage:bgName] forState:UIControlStateNormal];
        NSString *SelectedBgName;
        if (i ==0) {
            SelectedBgName =@"SegmentedControl_Left_Selected";
        }else if (i ==count -1){
            SelectedBgName =@"SegmentedControl_Right_Selected";
        }else{
            SelectedBgName =@"SegmentedControl_Selected";
        }
        
        [button setBackgroundImage:[UIImage resizableImage:SelectedBgName] forState:UIControlStateSelected];
        [self addSubview:button];
    }

}
- (void)buttonClicked:(SegementButton *)button{
    if ([self.delegate respondsToSelector:@selector(segementControl:from:to:)]) {
        [self.delegate segementControl:self from:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected =NO;
    button.selected = YES;
    self.selectedButton =button;

}

- (void)setSelectedSegmentIndex:(int)selectedSegmentIndex{
    if (selectedSegmentIndex <0 ||selectedSegmentIndex >=self.items.count) {
        return;
    }
    SegementButton *segement =self.subviews[selectedSegmentIndex];
    [self buttonClicked:segement];
}
- (int)selectedSegmentIndex{

    return self.selectedButton.tag;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    int count =self.subviews.count;
    for (int i =0; i<count; i++) {
        SegementButton *button =self.subviews[i];
        button.y =0;
        button.width =(self.width/count);
        button.height =self.height;
        button.x =i*button.width;
        
        //        NSLog(@"%@",button);
    }
    
}
@end
