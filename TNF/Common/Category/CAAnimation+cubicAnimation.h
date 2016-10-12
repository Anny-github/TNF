//
//  CAAnimation+cubicAnimation.h
//  CubeEffect
//
//  Created by yeke on 21/06/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (CAAnimation_cubicAnimation)
+ (CAKeyframeAnimation*)animationInterpolationCurveWithKeyPath:(NSString*)keyPath
                                        withInterPolationCount:(NSInteger)count
                                                  withDuration:(NSTimeInterval)duration
                                           withProcessingBlock:(void (^)(NSMutableArray* values,NSMutableArray * timingFunctions,int index,int count))block;

@end
