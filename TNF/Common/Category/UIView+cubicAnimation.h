//
//  UIView+cubicAnimation.h
//  CubeEffect
//
//  Created by yeke on 21/06/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_cubicAnimation)
- (void)cubeTransitionSubViewIn:(UIView*)subViewIn 
                     SubViewOut:(UIView*)subViewOut
                      direction:(BOOL)turnUp
              animationDuration:(NSTimeInterval)duration
                   withDelegate:(id)delegateForAnimationIn
                   withDelegate:(id)delegateForAnimationOut
                completionBlock:(void(^)(void))completionBlock;
- (void)cubeTransitionSubViewIn:(UIView*)subViewIn 
                     SubViewOut:(UIView*)subViewOut
                      direction:(BOOL)turnUp
                   withDelegate:(id)delegateForAnimationIn
                   withDelegate:(id)delegateForAnimationOut
                completionBlock:(void(^)(void))completionBlock;

@end
