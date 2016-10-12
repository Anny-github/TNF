//
//  CorrectPopView.m
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "CorrectPopView.h"
#import "SelectMoneyView.h"
#import "AttributeLabel.h"

@interface CorrectPopView ()
{
    UIButton *firstV;
    UIButton *secondV;
    UIButton *thirdV;
}
@end
@implementation CorrectPopView

-(CorrectPopView*)initWithData:(NSDictionary*)dataDic requestCorrectSuccess:(RequestSuccess)requestSuccess{
    if (self = [super init]) {
        self.requestSuccess = requestSuccess;
        [self initViews];
    }
    return self;
}


#pragma mark --initViews--
-(void)initViews{
    
    self.frame = kWindow.bounds;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    //背景view
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ratioWidth, 64*ratioHeight, self.width - 20*ratioWidth, self.height - 64*ratioHeight - 80*ratioHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    //平分六部分
    CGFloat height = bgView.height / 6.0;
    CGFloat width = bgView.width;
    
    //
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-5, -5, width+10, height+5)];
    label.backgroundColor = [MyColor colorWithHexString:@"0xF7226E"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:19];
    label.text = @"发布成功";
    label.textColor = [UIColor whiteColor];
    [bgView addSubview:label];
    
    //title
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, height, width, height)];
    titleL.backgroundColor = [UIColor whiteColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.numberOfLines = 0;
    titleL.font = [UIFont systemFontOfSize:17];
    titleL.text = @"知其然，更要知其所以然\n批改来一发";
    titleL.lineBreakMode = NSLineBreakByCharWrapping;
    [bgView addSubview:titleL];
    
    //line
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleL.bottom-1, bgView.width, 1)];
    line1.image = [UIImage imageNamed:@"lineBg"];
    [bgView addSubview:line1];
    
    //first
    firstV = [[UIButton alloc]initWithFrame:CGRectMake(0, height*2, width, height)];
    firstV.backgroundColor = [UIColor  clearColor];
    firstV.tag = 10000;
    [bgView addSubview:firstV];
    
    UILabel *topL1 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0-20, width/2.0, 20) textColor:UIColorTitle textFont:[UIFont systemFontOfSize:18] labelTag:0];
    topL1.text = @"初级批改";
    [firstV addSubview:topL1];
    
    UILabel *bottomL1 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0, bgView.width - 20*ratioWidth - 60*ratioWidth, 40) textColor:UIColorSubTitle textFont:[UIFont systemFontOfSize:15] labelTag:0];
    bottomL1.text = @"仅指出语法错误";
    bottomL1.numberOfLines = 0;
   [firstV addSubview:bottomL1];
    
    UILabel *money1 = [[UILabel alloc]initWithFrame:CGRectMake(bgView.width - 90*ratioWidth, 0, 70*ratioWidth, height)];
    money1.textAlignment = NSTextAlignmentRight;
    money1.text = @"5元";
    [firstV addSubview:money1];
    
    //line
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, firstV.bottom-1, bgView.width, 1)];
    line2.image = [UIImage imageNamed:@"lineBg"];
    [bgView addSubview:line2];
    
    //second
    secondV = [[UIButton alloc]initWithFrame:CGRectMake(0, height*3, width, height)];
    secondV.backgroundColor = [UIColor  clearColor];
    secondV.tag = 10001;
    [bgView addSubview:secondV];
    
    UILabel *topL2 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0-20, width/2.0, 20) textColor:UIColorTitle textFont:[UIFont systemFontOfSize:18] labelTag:0];
    topL2.text = @"中级批改";
    [secondV addSubview:topL2];
    UILabel *bottomL2 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0, bottomL1.width, 40) textColor:UIColorSubTitle textFont:[UIFont systemFontOfSize:15] labelTag:0];
    bottomL2.numberOfLines = 0;
    bottomL2.text = @"仅指出语法错误+思路拓展";
    [secondV addSubview:bottomL2];
    
    UILabel *money2 = [[UILabel alloc]initWithFrame:CGRectMake(bgView.width - 90*ratioWidth, 0, 70*ratioWidth, height)];
    money2.text = @"5元";
    money2.textAlignment = NSTextAlignmentRight;
    [secondV addSubview:money2];
    
    //line
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, secondV.bottom-1, bgView.width, 1)];
    line3.image = [UIImage imageNamed:@"lineBg"];
    [bgView addSubview:line3];

    
    //third
    thirdV = [[UIButton alloc]initWithFrame:CGRectMake(0, height*4, width, height)];
    thirdV.backgroundColor = [UIColor  clearColor];
    thirdV.tag = 10002;
    [bgView addSubview:thirdV];
    
    UILabel *topL3 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0-20, width/2.0, 20) textColor:UIColorTitle textFont:[UIFont systemFontOfSize:18] labelTag:0];
    topL3.text = @"高级批改";
    [thirdV addSubview:topL3];
    UILabel *bottomL3 = [WXLabel UIlabelFrame:CGRectMake(20*ratioWidth, height/2.0, bottomL1.width, height/2.0) textColor:UIColorSubTitle textFont:[UIFont systemFontOfSize:15] labelTag:0];
    bottomL3.text = @"仅指出语法错误+思路拓展+发音错误+好词好句";
    bottomL3.numberOfLines = 0;
    [bottomL3 sizeToFit];
    [thirdV addSubview:bottomL3];
    
    UILabel *money3 = [[UILabel alloc]initWithFrame:CGRectMake(bgView.width - 90*ratioWidth, 0, 70*ratioWidth, height)];
    money3.textAlignment = NSTextAlignmentRight;
    money3.text = @"5元";
    [thirdV addSubview:money3];


    //确定按钮
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*ratioWidth, thirdV.bottom+20*ratioHeight, bgView.width - 80*ratioWidth, 40*ratioHeight)];
    [sureBtn setTitle:@"必须来一发" forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sureBtn];
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2.0 - 30, bgView.bottom, 60, 60)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    [firstV addTarget:self action:@selector(selectedView:) forControlEvents:UIControlEventTouchUpInside];
    [secondV addTarget:self action:@selector(selectedView:) forControlEvents:UIControlEventTouchUpInside];
    [thirdV addTarget:self action:@selector(selectedView:) forControlEvents:UIControlEventTouchUpInside];

    secondV.backgroundColor = UIColor2(<#灰色背景#>);
}

#pragma mark --点击事件
-(void)closeBtnClick{
    
    [self hide];
}
-(void)sureBtnClick{
    
    //确认请求去改
    //查看余额是否够
    SelectMoneyView *view = [SelectMoneyView showWithMoneyData:@{}];
    view.selectedMoney = ^{
        [self removeFromSuperview];
    };
    
    self.requestSuccess();
    
}

-(void)selectedView:(UIButton*)btn{
    
    firstV.backgroundColor = [UIColor whiteColor];
    secondV.backgroundColor = [UIColor whiteColor];
    thirdV.backgroundColor = [UIColor whiteColor];
    btn.backgroundColor = UIColor2(<#灰色背景#>);
    
}

-(void)show{
    [kWindow addSubview:self];

}

-(void)hide{
    
    [self removeFromSuperview];
}

@end
