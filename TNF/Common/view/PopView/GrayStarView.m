//
//  GrayStarView.m
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "GrayStarView.h"

@implementation GrayStarView

//不加载xib的时候调用此初始化方法

- (instancetype)initWithFrame:(CGRect)frame  starmore:(NSInteger)more Grayindex:(NSInteger )Grayindex{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _createLightGrayStarview:more Grayindex:Grayindex];
    }
    
    
    return self;
}

//思路：创建两个视图，金色和灰色的视图，利用传进来的平均分来使金色覆盖灰色

//1、创建金色和灰色的量的视图，利用平铺的效果取得五颗星星的背景颜色视图

- (void)_createLightGrayStarview:(NSInteger)more Grayindex:(NSInteger)Grayindex{

    UIImage *lightGray = [UIImage imageNamed:@"star_03"];
    UIImage * gray = [UIImage imageNamed:@"star_01"];
    
    CGFloat grayKwidth = ratioHeight*30/2;
    
    for (int i =0; i<Grayindex; i++) {
        _grayview = [[UIImageView alloc]initWithFrame:CGRectMake((grayKwidth+10*ratioWidth/2)*i,0, ratioHeight*30/2, grayKwidth)];
        _grayview.image = gray;
        [self addSubview:_grayview];
    }
    
    for (int a = 0; a<more; a++) {
        _lightGrayView = [[UIImageView alloc]initWithFrame:CGRectMake((grayKwidth+10*ratioWidth/2)*a,0, ratioHeight*30/2, grayKwidth)];
        _lightGrayView.image = lightGray;
        [self addSubview:_lightGrayView];
    }
    
}






@end
