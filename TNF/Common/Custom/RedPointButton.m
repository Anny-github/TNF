//
//  RedPointButton.m
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "RedPointButton.h"


@interface RedPointButton ()
{
    UILabel *_point;
}
@end
@implementation RedPointButton

-(UIButton*)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //红点
        _point = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-5, 0, 10, 10)];
        _point.layer.cornerRadius = 5;
        _point.layer.masksToBounds = YES;
        _point.backgroundColor = [UIColor redColor];
        [self addSubview:_point];
        
    }
    
    return self;
}

-(void)setPointHidden:(BOOL)hidden{
    _point.hidden = hidden;
}




@end
