//
//  LNWaterfallFlowFooterView.m
//  WaterfallFlowDemo
//
//  Created by Lining on 15/5/3.
//  Copyright (c) 2015年 Lining. All rights reserved.
//

#import "ImgCollecFootView.h"

@implementation ImgCollecFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0,50, 50)];
        self.indicator.center = self.center;
        [self addSubview:self.indicator];
    }
    return self;
}

@end
