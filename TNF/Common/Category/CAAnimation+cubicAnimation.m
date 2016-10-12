//
//  CAAnimation+cubicAnimation.m
//  CubeEffect
//
//  Created by yeke on 21/06/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "CAAnimation+cubicAnimation.h"


@implementation CAAnimation ( CAAnimation_cubicAnimation )
+ (CAKeyframeAnimation*)animationInterpolationCurveWithKeyPath:(NSString*)keyPath
                                        withInterPolationCount:(NSInteger)count
                                                  withDuration:(NSTimeInterval)duration
                                           withProcessingBlock:(void (^)(NSMutableArray* values,NSMutableArray * timingFunctions,int index,int count))block{
    if ([keyPath isEqualToString:@""]||keyPath == nil ||count <2) {
        return nil;
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *timingFunctions = [NSMutableArray array];
    for (int i = 0; i< count; i ++) {
        block(values,timingFunctions,i,count);
    }
    animation.values = values;
    animation.timingFunctions = timingFunctions;
    animation.duration = duration;
    return animation;
}
@end
