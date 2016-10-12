//
//  BuyCourSucView.m
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BuyCourSucView.h"

@implementation BuyCourSucView

-(BuyCourSucView *)initWithCourseName:(NSString *)name enterOnLive:(EnterOnLive)enterOnlive{
    if (self = [super init]) {
        self.enterOnLive = enterOnlive;
        [self initViews];
    }
    return self;
}

-(void)initViews{
    self.frame = kWindow.bounds;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    
    //背景view
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ratioWidth, self.height/4.0-20*ratioHeight, self.width - 20*ratioWidth, self.height/2.0 + 30*ratioHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-5, -5, bgView.width+10, bgView.height/5.0 )];
    label.backgroundColor = [MyColor colorWithHexString:@"0xF7226E"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:19];
    label.text = @"购课成功";
    label.textColor = [UIColor whiteColor];
    [bgView addSubview:label];
    
    //对勾img
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, label.bottom + 25*ratioHeight, 55*ratioWidth, 55*ratioWidth)];
    imgV.image = [UIImage imageNamed:@"successIcon"];
    imgV.centerX = bgView.width/2.0;
    [bgView addSubview:imgV];
    
    UILabel *tiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imgV.bottom + 20*ratioHeight, bgView.width, 20*ratioHeight)];
    tiLabel.textAlignment = NSTextAlignmentCenter;
    tiLabel.font = [UIFont systemFontOfSize:16];
    tiLabel.text = @"您已成功购买直播课“热点预测5”";
    tiLabel.textColor = [MyColor colorWithHexString:@"0x333333"];
    [bgView addSubview:tiLabel];
    
    UIButton *enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(30*ratioWidth, tiLabel.bottom + 20*ratioHeight, bgView.width-60*ratioWidth, 50*ratioHeight)];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    [enterBtn setTitle:@"进入直播课" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [bgView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(enterOnLiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *bottomL = [[UILabel alloc]initWithFrame:CGRectMake(10*ratioWidth, enterBtn.bottom + 15*ratioHeight, bgView.width-20*ratioWidth, 40*ratioHeight)];
    bottomL.textAlignment = NSTextAlignmentCenter;
    bottomL.text = @"首页点击我的头像进入“我的课程”，查看已购买课程";
    bottomL.numberOfLines = 0;
    bottomL.textColor = [MyColor colorWithHexString:@"0x333333"];
    bottomL.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:bottomL];
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2.0 - 30, bgView.bottom+25*ratioHeight, 60, 60)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];

}

-(void)enterOnLiveBtnClick{
    //进入直播课
    self.enterOnLive();

    [self hidden];
}
-(void)closeBtnClick{
    [self removeFromSuperview];
}

-(void)show{
    [kWindow addSubview:self];
}

-(void)hidden{
    [self removeFromSuperview];
}

@end
