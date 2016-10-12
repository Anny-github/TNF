//
//  WSShapeLayer.h
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WSShapeLayer : CAShapeLayer

@property(nonatomic,assign)double progress;
- (id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth insets:(UIEdgeInsets)insets;

@end
