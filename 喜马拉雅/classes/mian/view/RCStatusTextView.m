//
//  RCTextView.m
//  高仿微博
//
//  Created by Raychen on 15/4/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//  显示正文的textview

#import "RCStatusTextView.h"
#import "RCSpecialText.h"
#define RCStatusTextViewCoverTag 10
@implementation RCStatusTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        self.scrollEnabled = NO;

    }
    
    return self;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint  point = [touch locationInView:touch.view];
    RCSpecialText * specailText = [self specialWithPoint:point];
    if ([specailText.text hasPrefix:@"@"]) {
        [self didClickedEmetion:specailText.text];
    }else if ([specailText.text hasPrefix:@"#"]&&[specailText.text hasSuffix:@"#"]){
        [self didClickedTopic:specailText.text];

    
    }else if([specailText.text hasPrefix:@"http"]){
        [self didClickedWebPage:specailText.text];



    }
    //取出存放 RCSpecialText模型的数组
       NSArray * specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    //是否是特殊字符
    BOOL isSpecial = NO;
    //遍历 RCSpecialText模型的数组
    for (RCSpecialText * special in specials) {
        //设置选中的range
        self.selectedRange = special.range;
        //，根据selectedTextRange取得选中的rect

       NSArray * rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //遍历 rects

        for (UITextSelectionRect * selectedRect in rects) {
       
            CGRect rect = selectedRect.rect;

            if (rect.size.width == 0 && rect.size.height == 0) {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) {
                isSpecial = YES;    //是特殊字符
         
                break;
            }
        }
        if (isSpecial) {     //如果是特殊字符

            for (UITextSelectionRect * selectedRect in rects) {
                
                CGRect rect = selectedRect.rect;
                if (rect.size.width == 0 && rect.size.height == 0) {
                    continue;
                }

                //插入点中时的背景
                UIView * cover = [[UIView alloc]init];
                cover.tag = RCStatusTextViewCoverTag;
                cover.layer.cornerRadius = 5;
                cover.backgroundColor = [UIColor greenColor];
                cover.frame = rect;
                [self insertSubview:cover atIndex:0];
                           }
            break;

        }
    }
}

/**
 *  根据当前的触摸点找出触摸点所在的文字模型
 *
 *  @param point 触摸点
 *
 *  @return RCSpecialText
 */
- (RCSpecialText *)specialWithPoint:(CGPoint)point{
    NSArray * specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    __block  RCSpecialText * specialText = nil;
    [specials enumerateObjectsUsingBlock:^(RCSpecialText *special, NSUInteger idx, BOOL *stop) {
        //设置选中的range
        self.selectedRange = special.range;
        //，根据selectedTextRange取得选中的rect
        
        NSArray * rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //遍历 rects
        //是否是特殊字符
        for (UITextSelectionRect * selectedRect in rects) {
            
            CGRect rect = selectedRect.rect;
            if (rect.size.width == 0 && rect.size.height == 0) {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) {
                specialText = special;
                break;
            }
        }


    }];
    return specialText;

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self touchesCancelled:touches withEvent:event];
    });

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //移除背景
    [self removeCoverView];
    
}
/**
 *  处理当前点击的位置把事件交给谁处理
 *  返回YES 自己处理
    返回NO 交给别的view处理
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    //取出存放 RCSpecialText模型的数组
    NSArray * specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    //遍历 RCSpecialText模型的数组
    for (RCSpecialText * special in specials) {
        //设置选中的range
        self.selectedRange = special.range;
        //，根据selectedTextRange取得选中的rect
        
        NSArray * rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //遍历 rects
        
        for (UITextSelectionRect * selectedRect in rects) {
            
            CGRect rect = selectedRect.rect;
            if (rect.size.width == 0 && rect.size.height == 0) {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) {
                return YES;
            }
            
        }}

    return NO;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
#pragma mark 点击了提到某人
- (void)didClickedEmetion:(NSString *)text{
//    NSLog(@"提到某人");
//    RCEmetionController *  emetionC= [[RCEmetionController alloc]init];
//    emetionC.text = text;
//      [[self navC] pushViewController:emetionC animated:YES];
    [self removeCoverView];

}
#pragma mark 点击了话题

- (void)didClickedTopic:(NSString *)text{
//    NSLog(@"话题");
//  RCTopicViewController *  topicC = [[RCTopicViewController alloc]init ];
//    topicC.text = text;
//    [[self navC] pushViewController:topicC animated:YES];
    [self removeCoverView];



}
#pragma mark 点击了网页

- (void)didClickedWebPage:(NSString *)text{
//        NSLog(@"网页");
//    RCWebPageViewController *  webPageC = [[RCWebPageViewController alloc]init];
//    webPageC.text = text;
//          [[self navC] pushViewController:webPageC animated:YES];
    [self removeCoverView];

}
- (UINavigationController *)navC {
    UITabBarController * tabBar = (UITabBarController *)[UIApplication  sharedApplication].keyWindow.rootViewController;
    UINavigationController * navC = (UINavigationController *)tabBar.selectedViewController;
    return navC;

}
- (void)removeCoverView{
    //移除背景
    for (UIView * view in self.subviews) {
        if (view.tag == RCStatusTextViewCoverTag) {
            [view removeFromSuperview];
        }
    }
    
}
@end
