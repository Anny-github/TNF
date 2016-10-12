//
//  WSShapeLayer.m
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "WSShapeLayer.h"


@implementation WSShapeLayer

- (id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth insets:(UIEdgeInsets)insets
{

    if (self = [super init])
    {
        self.frame = frame;
        self.lineWidth = strokeWidth;
        
        CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds) - insets.top - insets.bottom;
        
        self.path = [[UIBezierPath bezierPathWithArcCenter:arcCenter
                                                         radius:radius
                                                     startAngle:M_PI
                                                       endAngle:-M_PI
                                                      clockwise:YES] CGPath];
        self.strokeColor = [UIColor redColor].CGColor;
        self.fillColor = [UIColor clearColor].CGColor;
    }
    return self;
}


- (void)setProgress:(double)progress {
    _progress = progress;
    [self updateAnimations];
}

- (void)updateAnimations{
    
    self.strokeEnd = self.progress;
    [self didChangeValueForKey:@"endValue"];
}

@end
