//
//  MymedalController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MymedalController.h"
#import "RewardController.h"

@interface MymedalController ()
{
    NSArray *_medalArr;
    UIView *_corverView;
}
@end

@implementation MymedalController

- (void)viewDidLoad {
    [super viewDidLoad];
    _medalArr = @[@"一鸣惊人勋章",@"魅力勋章",@"7芒星勋章",@"百发勋章",@"口语控勋章",@"无双勋章"];
    self.text = @"勋章墙";
    [self initViews];
}

-(void)initViews{
    
    //
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightBtn setTitle:@"奖励" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
    CGFloat topMargin = 20;
    CGFloat width = kScreenWidth/3.0;
    CGFloat height = width;
    
    for (int i=0; i<_medalArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i%3)*width, topMargin + (i/3)*height, width, height)];
        [btn setTitle:_medalArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColor(<#深色背景#>) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setImage:[UIImage imageNamed:@"b3"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:8*ratioHeight];
    }
}


-(void)rightBtnClick{
    [self.navigationController pushViewController:[[RewardController alloc]init] animated:YES];
}

-(void)buttonClick:(UIButton*)btn{
    [self medalViewWithTitle:@"一鸣惊人勋章" img:[UIImage imageNamed:@"course_notBegin"] content:@"一鸣惊人勋章一鸣惊人勋章一鸣惊人勋章一鸣惊人勋章一鸣惊人勋章一鸣惊人勋章一鸣惊人勋章"];
}

-(void)medalViewWithTitle:(NSString*)title img:(UIImage*)img  content:(NSString*)content{
    _corverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _corverView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(15*ratioWidth, kScreenHeight/4.0, kScreenWidth-30*ratioWidth, kScreenHeight/2.0)];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.layer.cornerRadius = 5.0;
    whiteV.layer.masksToBounds = YES;
    [_corverView addSubview:whiteV];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, whiteV.width, whiteV.height/4.0)];
    titleL.text = title;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [whiteV addSubview:titleL];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleL.bottom, whiteV.height/2.2, whiteV.height/2.2)];
    imgView.image = img;
    [whiteV addSubview:imgView];
    imgView.centerX = whiteV.width/2.0;
    
    UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(20*ratioWidth, imgView.bottom, whiteV.width-40*ratioWidth, whiteV.height - imgView.bottom)];
    contentL.text = content;
    contentL.numberOfLines = 0;
    contentL.textAlignment = NSTextAlignmentCenter;
    [contentL sizeToFit];
    contentL.font = [UIFont systemFontOfSize:12];
    [whiteV addSubview:contentL];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, whiteV.bottom + 20*ratioHeight, 60, 60)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closeBtn.centerX = _corverView.width/2.0;
    [closeBtn addTarget:self action:@selector(removeCorVerView) forControlEvents:UIControlEventTouchUpInside];
    [_corverView addSubview:closeBtn];

    [kWindow addSubview:_corverView];
}

-(void)removeCorVerView{
    
    [_corverView removeFromSuperview];
}

@end
