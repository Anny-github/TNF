//
//  UIView+cubicAnimation.m
//  CubeEffect
//
//  Created by yeke on 21/06/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "UIView+cubicAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import "CAAnimation+cubicAnimation.h"
#define DEGREE_TO_RADIUS(x) (M_PI*x/180)
#define kInterPolation_Count 20
@implementation UIView (UIView_cubicAnimation)


- (CAAnimationGroup*)cubicAnimationCenterToTopwithDelegate:(id)delegate
                                              withDuration:(NSTimeInterval)duration
                                                    radius:(CGFloat)radius
{
    // transform
//    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
//    transform.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    transform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREE_TO_RADIUS(90), 1.0f, 0, 0 )];
//    transform.duration = 1.f;
    //position
    __block CGFloat r = radius;
    CAKeyframeAnimation *transform = [CAAnimation animationInterpolationCurveWithKeyPath:@"transform"
                                                                  withInterPolationCount:kInterPolation_Count
                                                                            withDuration:duration
                                                                     withProcessingBlock:^(NSMutableArray* values,NSMutableArray *timingFunctions,int index,int count){
                                                                         CGFloat radius = DEGREE_TO_RADIUS(90*(float)index/(float)(count -1));
                                                                         
                                                                         CATransform3D transform3d = CATransform3DMakeTranslation(0, -r*sinf(radius), -r*(1-cosf(radius)));
//                                                                         CATransform3D transform3d = CATransform3DIdentity;
                                                                         transform3d = CATransform3DRotate(transform3d, radius, 1.f, 0, 0);
                                                                         NSValue *value = [NSValue valueWithCATransform3D:transform3d];
                                                                         [values addObject:value];
                                                                         if (index > 0) {
                                                                             [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                                                                         }
                                                                        
                                                                     }
                                      ];
    CAAnimationGroup *cubicAnimation = [CAAnimationGroup animation];
    cubicAnimation.duration = duration;
    cubicAnimation.delegate = delegate;

    cubicAnimation.animations = [NSArray arrayWithObjects:transform,nil];
    
    return cubicAnimation;
}


- (CAAnimationGroup*)cubicAnimationCenterToBottomwithDelegate:(id)delegate
                                                 withDuration:(NSTimeInterval)duration
                                                       radius:(CGFloat)radius
{
    // transform
    __block CGFloat r = radius;
    CAKeyframeAnimation *transform = [CAAnimation animationInterpolationCurveWithKeyPath:@"transform"
                                                                  withInterPolationCount:kInterPolation_Count
                                                                            withDuration:duration
                                                                     withProcessingBlock:^(NSMutableArray* values,NSMutableArray *timingFunctions,int index,int count){
                                                                         
                                                                         CGFloat radius = DEGREE_TO_RADIUS(90*(float)index/(float)(count -1));
                                                                         
                                                                         CATransform3D transform3d = CATransform3DMakeTranslation(0, r*sinf(radius), -r*(1-cosf(radius)));
                                                                         transform3d = CATransform3DRotate(transform3d, radius, -1.f, 0, 0);
                                                                         NSValue *value = [NSValue valueWithCATransform3D:transform3d];
                                                                         [values addObject:value];
                                                                         if (index > 0) {
                                                                             [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                                                                         }
                                                                         
                                                                     }
                                      ];

    //position
    
 
    CAAnimationGroup *cubicAnimation = [CAAnimationGroup animation];
    cubicAnimation.duration = duration;
    cubicAnimation.delegate = delegate;
    
    cubicAnimation.animations = [NSArray arrayWithObjects:transform,nil];
    
    return cubicAnimation;
}


- (CAAnimationGroup*)cubicAnimationBottomToCenterwithDelegate:(id)delegate
                                                 withDuration:(NSTimeInterval)duration
                                                       radius:(CGFloat)radius
{
    // transform
    __block CGFloat r = radius;
    CAKeyframeAnimation *transform = [CAAnimation animationInterpolationCurveWithKeyPath:@"transform"
                                                                  withInterPolationCount:kInterPolation_Count
                                                                            withDuration:duration
                                                                     withProcessingBlock:^(NSMutableArray* values,NSMutableArray *timingFunctions,int index,int count){
                                                                         CGFloat radius = DEGREE_TO_RADIUS(90*(float)(count -1 -index)/(float)(count -1));
                                                                         
                                                                         CATransform3D transform3d = CATransform3DMakeTranslation(0, r*sinf(radius), -r*(1-cosf(radius)));
                                                                         transform3d = CATransform3DRotate(transform3d, radius, -1.f, 0, 0);
                                                                         NSValue *value = [NSValue valueWithCATransform3D:transform3d];
                                                                         [values addObject:value];
                                                                         if (index > 0) {
                                                                             [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                                                                         }

                                                                     }
                                      ];
    
    CAAnimationGroup *cubicAnimation = [CAAnimationGroup animation];
    cubicAnimation.duration = duration;
    cubicAnimation.delegate = delegate;
    
    cubicAnimation.animations = [NSArray arrayWithObjects:transform,nil];
    
    return cubicAnimation;
}


- (CAAnimationGroup*)cubicAnimationTopToCenterwithDelegate:(id)delegate
                                              withDuration:(NSTimeInterval)duration
                                                    radius:(CGFloat)radius
{
    // transform
    CGFloat r = radius;
    CAKeyframeAnimation *transform = [CAAnimation animationInterpolationCurveWithKeyPath:@"transform"
                                                                  withInterPolationCount:kInterPolation_Count
                                                                            withDuration:duration
                                                                     withProcessingBlock:^(NSMutableArray* values,NSMutableArray *timingFunctions,int index,int count){
                                                                         CGFloat radius = DEGREE_TO_RADIUS(90*(float)(count - 1 - index)/(float)(count -1));
                                                                         
                                                                         CATransform3D transform3d = CATransform3DMakeTranslation(0, -r*sinf(radius), -r*(1-cosf(radius)));
                                                                         transform3d = CATransform3DRotate(transform3d, radius, 1.f, 0, 0);
                                                                         NSValue *value = [NSValue valueWithCATransform3D:transform3d];
                                                                         [values addObject:value];
                                                                         if (index > 0) {
                                                                             [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                                                                         }

                                                                         
                                                                     }
                                      ];

    //position
    
    CAAnimationGroup *cubicAnimation = [CAAnimationGroup animation];
    cubicAnimation.duration = duration;
    cubicAnimation.delegate = delegate;
    
    cubicAnimation.animations = [NSArray arrayWithObjects:transform,nil];
    
    return cubicAnimation;
}


- (void)cubeTransitionSubViewIn:(UIView*)subViewIn 
                     SubViewOut:(UIView*)subViewOut
                      direction:(BOOL)turnUp
              animationDuration:(NSTimeInterval)duration
                   withDelegate:(id)delegateForAnimationIn
                   withDelegate:(id)delegateForAnimationOut
                completionBlock:(void(^)(void))completionBlock{
    if (subViewIn && subViewOut) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.001;
        [self.layer setSublayerTransform:transform];
        [CATransaction begin];
        [CATransaction setAnimationDuration:duration];
        [CATransaction setCompletionBlock:completionBlock];
        if (turnUp) {
            CAAnimation *inAnimation = [self cubicAnimationBottomToCenterwithDelegate:delegateForAnimationIn
                                                                         withDuration:duration
                                                                               radius:subViewIn.frame.size.height/2.0];
            [subViewIn.layer addAnimation:inAnimation forKey:@"cubeIn"];
            CAAnimation *outAnimation = [self cubicAnimationCenterToTopwithDelegate:delegateForAnimationOut
                                                                       withDuration:duration
                                                                             radius:subViewOut.frame.size.height/2.0];
            [subViewOut.layer addAnimation:outAnimation forKey:@"cubeOut"];
        }else{
            CAAnimation *inAnimation = [self cubicAnimationTopToCenterwithDelegate:delegateForAnimationIn
                                                                      withDuration:duration
                                                                            radius:subViewIn.frame.size.height/2.0];
            [subViewIn.layer addAnimation:inAnimation forKey:@"cubeIn"];
            CAAnimation *outAnimation = [self cubicAnimationCenterToBottomwithDelegate:delegateForAnimationOut
                                                                          withDuration:duration
                                                                                radius:subViewOut.frame.size.height/2.0];
            [subViewOut.layer addAnimation:outAnimation forKey:@"cubeOut"];
            
        }
        [CATransaction commit];
        
    }else{
        NSLog(@"subViewIn or subViewOut is nil!");
    }
}
- (void)cubeTransitionSubViewIn:(UIView*)subViewIn 
                     SubViewOut:(UIView*)subViewOut
                      direction:(BOOL)turnUp
                   withDelegate:(id)delegateForAnimationIn
                   withDelegate:(id)delegateForAnimationOut
                completionBlock:(void(^)(void))completionBlock{
    [self cubeTransitionSubViewIn:subViewIn 
                       SubViewOut:subViewOut
                        direction:turnUp
                animationDuration:.4f
                     withDelegate:delegateForAnimationIn
                     withDelegate:delegateForAnimationOut
                  completionBlock:completionBlock];
}

@end
