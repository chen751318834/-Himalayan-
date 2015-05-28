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
@property(nonatomic,weak) UIButton * selectedButton;
@property(nonatomic,strong) NSMutableArray  *buttons;
@property(nonatomic,strong) NSMutableArray  *sliders;
@property(nonatomic,weak) UIView   *sliderView;

@end
@implementation RCSegementControl
-  (NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons= [NSMutableArray array];

    }
    return _buttons;
}
-  (NSMutableArray *)sliders{
    if (!_sliders) {
        self.sliders= [NSMutableArray array];

    }
    return _sliders;
}

- (void)setItems:(NSArray *)items{
    _items =items;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger count = items.count;
    for (NSUInteger i =0; i<count; i++) {
        UIButton *button =items[i];
        button.tag = i ;
        if (button.isSelected) {
            [button setImage:button.imageView.image forState:UIControlStateSelected];
            [button setTitle:button.titleLabel.text forState:UIControlStateSelected];
        }else{
            [button setImage:button.imageView.image forState:UIControlStateNormal];
            [button setTitle:button.titleLabel.text forState:UIControlStateNormal];
        }
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

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
        [self.buttons addObject:button];
    }
    for (int i = 0; i<items.count - 1; i++) {
        UIView * sliderView = [[UIView alloc]init];
        sliderView.backgroundColor = [UIColor whiteColor];
        sliderView.alpha = 0.5;
        [self addSubview:sliderView];
        self.sliderView = sliderView;
        [self.sliders addObject:sliderView];

    }

}
- (void)buttonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(segementControl:button:from:to:)]) {
        [self.delegate segementControl:self button:button from:button.tag to:self.selectedButton.tag];
    }
//    self.selectedButton.selected =NO;
//    button.selected = YES;
//    self.selectedButton =button;

}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex{
//    if (selectedSegmentIndex < 0 ||selectedSegmentIndex >=self.items.count) {
//        return;
//    }
    UIButton *segement =self.subviews[selectedSegmentIndex];
    [self buttonClicked:segement];
}
- (NSUInteger)selectedSegmentIndex{

    return self.selectedButton.tag;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count =self.buttons.count;
    CGFloat buttonW = (self.width/count);
    for (int i =0; i<count; i++) {
        UIButton *button =self.buttons[i];
        button.y =0;
        button.width =(self.width/count);
        button.height =self.height;
        button.x =i*button.width;
        }
    for (int i = 0; i<self.sliders.count; i++) {
        UIView * slilerView = self.sliders[i];
        CGFloat sliderViewX = buttonW*(i+1);
        slilerView.width = 0.5;
        slilerView.height = self.bounds.size.height;
        slilerView.y = 0;
        slilerView.x = sliderViewX;
    }
}
@end
