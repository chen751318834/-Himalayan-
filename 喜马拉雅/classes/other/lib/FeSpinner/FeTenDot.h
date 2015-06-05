//
//  FeTenDot.h
//  FeSpinner
//
//  Created by Nghia Tran on 12/13/13.
//  Copyright (c) 2013 fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeTenDot : UIView
@property (assign, nonatomic) CATransform3D originalTransform3D;
-(id) initDotAtMainView:(UIView *) mainView atIndex:(NSInteger) index;

-(void) start;
-(void) stop;
-(void) reset;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
