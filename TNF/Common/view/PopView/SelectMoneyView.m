//
//  SelectMoneyView.m
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SelectMoneyView.h"
#import "PayController.h"

#define COUNT 3
@implementation SelectMoneyView

+(instancetype)showWithMoneyData:(NSDictionary*)dic{
    SelectMoneyView *view = [[SelectMoneyView alloc]initWithMoneyData:dic];
    [kWindow addSubview:view];
    return view;
}
-(instancetype)initWithMoneyData:(NSDictionary*)dic{
    if (self = [super init]) {
        
        [self initViews];
    }
    return self;
}

-(void)initViews{
    self.frame = kWindow.bounds;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ratioWidth, self.height/3.0, self.width-20*ratioWidth, self.height/3.0)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-5, -5, bgView.width+10, bgView.height/4.0+5)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.backgroundColor = UIColor7(<#粉红#>);
    label.textColor = [UIColor whiteColor];
    label.text = @"余额不足, 请充值";
    [bgView addSubview:label];
    
    CGFloat left =20*ratioWidth;
    CGFloat margin = 15*ratioWidth;
    CGFloat width = (bgView.width-left*2 - margin*(COUNT-1))/COUNT;
    CGFloat height = width;
    
    for (int i=0; i<COUNT; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(left+i*(width+margin), 0, width, height)];
        [bgView addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"moneyBg"] forState:UIControlStateNormal];
        [btn setTitle:@"30" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(selectBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        btn.centerY = (bgView.height - label.height)/2.0 + label.bottom;
        
    }
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2.0 - 30, bgView.bottom+15*ratioHeight, 60, 60)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
}

-(void)selectBtnCLick:(UIButton*)btn{
    self.selectedMoney();
    [self removeFromSuperview];
    //金额
    
    UIViewController *currentVC = [TNFPublicTool getCurrentVC];
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)currentVC pushViewController:[[PayController alloc]init] animated:YES];

    }else{
        [currentVC.navigationController pushViewController:[[PayController alloc]init] animated:YES];

    }
    
    
    
}

-(void)closeBtnClick{
    
    [self removeFromSuperview];
}
@end
