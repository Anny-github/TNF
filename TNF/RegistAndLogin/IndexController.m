//
//  IndexController.m
//  TNF
//
//  Created by wss on 16/5/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "IndexController.h"
#import "StoryController.h"

@interface IndexController ()
{
    UIImageView *topImgV;
    UIView *headArrView;
    
    NSMutableArray *headImgArr;
    
    UIImageView *currentImg;
}
@end

@implementation IndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.frame = kWindow.bounds;
    [self initViews];
}



#pragma mark --initViews--
-(void)initViews{
    
    UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImgV.image = [UIImage imageNamed:@"index_bg"];
    bgImgV.userInteractionEnabled = YES;
    [self.view addSubview:bgImgV];
    
    //title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    title.text = @"他们的故事";
    title.font = [UIFont systemFontOfSize:20];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [bgImgV addSubview:title];
    
    //
    topImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, (kScreenHeight-64)/3.0*2)];
    UIImage *img = [UIImage imageNamed:@"practiceBg"];
    topImgV.image = [img stretchableImageWithLeftCapWidth:topImgV.width/2 topCapHeight:topImgV.height/2];
    topImgV.userInteractionEnabled = YES;
    [self.view addSubview:topImgV];
    
    //
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, topImgV.bottom, kScreenWidth, self.view.height - 64-topImgV.height)];
    bottomV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomV];
    
    
    //
    UILabel *firstL = [[UILabel alloc]initWithFrame:CGRectMake(18*ratioWidth, 20*ratioHeight, 250, 20)];
    firstL.text = @"他们都通过托您的福";
    firstL.lineBreakMode = NSLineBreakByWordWrapping;
    firstL.font = [UIFont boldSystemFontOfSize:20];
    firstL.textColor = [UIColor whiteColor];
    [bottomV addSubview:firstL];
    UILabel *secondL = [[UILabel alloc]initWithFrame:CGRectMake(18*ratioWidth, firstL.bottom+10*ratioHeight, 250, 20)];
    secondL.text = @"练习托福/雅思口语提分了";
    secondL.lineBreakMode = NSLineBreakByWordWrapping;
    secondL.font = [UIFont boldSystemFontOfSize:20];
    secondL.textColor = [UIColor whiteColor];
    [bottomV addSubview:secondL];
    
    headArrView = [[UIView alloc]initWithFrame:CGRectMake(firstL.left, secondL.bottom, bottomV.width-firstL.left, bottomV.height - firstL.bottom)];
    [bottomV addSubview:headArrView];

    CGFloat x = 0;
    CGFloat width = 70*ratioWidth;
    CGFloat height = width;
    CGFloat y = headArrView.height - 35*ratioHeight - height;

    CGFloat margin = -10*ratioWidth;
    for (int i =0; i < 6; i++) {
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(i*(x+margin+width), y, width, height)];
        headImg.image = [UIImage imageNamed:@"bg01"];
        headImg.userInteractionEnabled = YES;
        headImg.layer.cornerRadius = width/2.0;
        headImg.layer.masksToBounds = YES;
        UIImageView *corverImgV = [[UIImageView alloc]initWithFrame:headImg.frame];
        [headArrView addSubview:headImg];
        [headArrView addSubview:corverImgV];
        corverImgV.userInteractionEnabled = YES;
        corverImgV.image = [UIImage imageNamed:@"roundWhite_bg"];
        corverImgV.tag = 1000 + i;
        [corverImgV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgClick:)]];
        
    }
    
    
    //有一个头像在上面
    
    currentImg = [[UIImageView alloc]initWithFrame:CGRectMake(70*ratioWidth, topImgV.height/5.0, 150*ratioWidth, 150*ratioWidth)];
    currentImg.image = [UIImage imageNamed:@"bg01"];
    currentImg.layer.cornerRadius = currentImg.width/2.0;
    currentImg.layer.masksToBounds = YES;
    [topImgV addSubview:currentImg];
    
    UIImageView *corver = [[UIImageView alloc]initWithFrame:currentImg.frame];
    corver.image = [UIImage imageNamed:@"roundWhiteBig"];

    [topImgV addSubview:corver];
    currentImg.userInteractionEnabled = YES;
    corver.userInteractionEnabled = YES;
    [corver addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCurrentImg)]];
    
    //点
    UIImageView *pointImg = [[UIImageView alloc]initWithFrame:CGRectMake(corver.centerX, corver.bottom-27*ratioHeight, 40*ratioWidth, 60*ratioHeight)];
    pointImg.image = [UIImage imageNamed:@"point_index"];
    [topImgV insertSubview:pointImg belowSubview:currentImg];
    pointImg.contentMode = UIViewContentModeCenter;
    pointImg.centerX = currentImg.centerX;
    
}

#pragma mark --点击当前头像，进入故事
-(void)tapCurrentImg{
    
    [self.navigationController pushViewController:[[StoryController alloc]init] animated:YES];
}
#pragma mark --点击头像
-(void)headImgClick:(UITapGestureRecognizer*)tap{
    
    UIImageView *view = (UIImageView*)tap.view;
    NSLog(@"view.tag---------%d",view.tag);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setNeedsLayout];
}


@end
