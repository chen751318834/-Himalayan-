//
//  FeLoadingIconBox.h
//  FeSpinner
//
//  Created by Nghia Tran on 12/19/13.
//  Copyright (c) 2013 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeLoadingIconBox : UIView
@property (assign, nonatomic, readonly) BOOL isAnimating;
-(id) initBoxAtIndex:(NSInteger) index;

-(void) playAnimate;
-(void) stopAnimate;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
