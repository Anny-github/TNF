//
//  HeaderViewDate.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "HeaderViewDate.h"

@implementation HeaderViewDate


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    
    return self;
}


#pragma mark --子视图--
-(void)initViews{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 45 * ratioHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0, kScreenWidth - 200, 45 * ratioHeight)];
    label1.textColor = [MyColor colorWithHexString:@"3a3a3a"];
    label1.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 200 - 10, 0, 200, 45 * ratioHeight)];
    
    label2.textColor = UIColor1(蓝);
    label2.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label2.textAlignment = NSTextAlignmentRight;
//    [view addSubview:label2];
    
    //日期
    UIButton *date = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 150 - 10, 0, 150, 45 * ratioHeight)];
    [date setImage:[UIImage imageNamed:@"timeIcon"] forState:UIControlStateNormal];
    [date setTitle:@"2016/03/10" forState:UIControlStateNormal];
    date.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [view addSubview:date];
    date.titleLabel.font = [UIFont systemFontOfSize:12];
    [date setTitleColor:[MyColor colorWithHexString:@"3a3a3a"] forState:UIControlStateNormal];
    date.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    
    
}

- (void)setText1:(NSString *)text1
{
    _text1 = text1;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text1];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:UIColor1(<#蓝#>)} range:NSMakeRange(0, 4)];
    label1.attributedText = attributeStr;
    
}


- (void)setText2:(NSString *)text2
{
    _text2 = text2;
    label2.text = text2;
    
    
}


@end
