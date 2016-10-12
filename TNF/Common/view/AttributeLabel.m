//
//  AttributeLabel.m
//  TNF
//
//  Created by wss on 16/5/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "AttributeLabel.h"

@interface AttributeLabel ()
{
    UILabel *leftL;
    UILabel *rightL;
}
@end
@implementation AttributeLabel

-(AttributeLabel*)initWithFrame:(CGRect)frame leftText:(NSString*)leftTitle rightText:(NSString*)rightTitle{
    if (self = [super initWithFrame:frame]) {
        self.leftTitle = leftTitle;
        self.rightTitle = rightTitle;
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    self.backgroundColor = [UIColor clearColor];
    leftL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height)];
    leftL.textColor = UIColor1(<#蓝#>);
    leftL.textAlignment = NSTextAlignmentRight;
    leftL.text = self.leftTitle;
    leftL.font = [UIFont systemFontOfSize:20];
    [self addSubview:leftL];
    
    rightL = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2.0, 6, self.frame.size.width/2.0, self.frame.size.height-6)];
    rightL.textColor = UIColor1(<#蓝#>);
    rightL.textAlignment = NSTextAlignmentLeft;
    rightL.text = self.rightTitle;
    rightL.font = [UIFont systemFontOfSize:10];
    [self addSubview:rightL];
//    leftL.backgroundColor = [UIColor purpleColor];
//    rightL.backgroundColor = [UIColor blackColor];
    
}

-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    leftL.text = leftTitle;
}

-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    rightL.text = rightTitle;
}
@end

