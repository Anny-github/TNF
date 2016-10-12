//
//  RootController.m
//  TNF
//
//  Created by dongliwei on 16/4/18.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "RootController.h"
#import "SetupViewController.h"
#import "OralController.h"
#import "BaseNavigationController.h"
//测试
#import "HomeController/HomeViewController.h"
#import "MyViewController/MyController.h"


@interface RootController ()
{
    OralController *oralVC;
    SetupViewController *setVC;
    BOOL tfIsTop; //首页在上
}
@property(nonatomic,strong)UIBarButtonItem *myTestBtn;
@property(nonatomic,strong)UIBarButtonItem *noticeBtn;
@property(nonatomic,strong)UIBarButtonItem *headerIconV;
@property(nonatomic,strong)UIBarButtonItem *homeBtn;

@end

@implementation RootController
/**
 *  懒加载 navigationBar上的按钮
 */
-(UIBarButtonItem *)homeBtn{
    if (_homeBtn == nil) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:[UIImage imageNamed:@"homeIcon"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [btn addTarget:self action:@selector(converse) forControlEvents:UIControlEventTouchUpInside];
        _homeBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _homeBtn;
}

-(UIBarButtonItem *)headerIconV{
    if (_headerIconV == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 3, 30)];
        imageV.image = [UIImage imageNamed:@"点点点"];
        imageV.contentMode = UIViewContentModeCenter;
        [view addSubview:imageV];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 0, 30, 30)];
        imageView.backgroundColor = [UIColor clearColor];
        [imageView sd_setImageWithURL:[[NSUserDefaults standardUserDefaults] objectForKey:IcanUrl] ];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15;
        imageView.userInteractionEnabled = YES;
        [view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(converse)];
        [view addGestureRecognizer:tap];
        _headerIconV = [[UIBarButtonItem alloc]initWithCustomView:view];


    }
    return _headerIconV;
    
    
}

-(UIBarButtonItem *)myTestBtn{
    
    if (_myTestBtn == nil) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        [btn setTitle:@"我的练习" forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [btn setTitleColor:UIColor9(<#白色#>) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(myTestBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _myTestBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];

    }
    return _myTestBtn;
}
-(UIBarButtonItem *)noticeBtn{
    if (_noticeBtn == nil) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _noticeBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
 

    }
    return _noticeBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor9(<#白色#>);
    
    oralVC = [[OralController alloc]init];

    setVC = [[SetupViewController alloc]init];

    [self addChildViewController:oralVC];
    [self addChildViewController:setVC];
    [self.view addSubview:setVC.view];
    [self.view addSubview:oralVC.view];
    
    self.navigationItem.leftBarButtonItem = self.headerIconV;
    self.navigationItem.rightBarButtonItem = self.myTestBtn;
    tfIsTop = YES;
    
    self.text = @"口语练习";
    
    //通知监听，备考信息修改
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(examInfoChange) name:Noti_ExamInfoChange object:nil];

}

-(void)converse{

    if (tfIsTop) { //到设置

        self.text = @"我的";
        self.navigationItem.leftBarButtonItem = self.homeBtn;
        self.navigationItem.rightBarButtonItem = self.noticeBtn;
        [self transitionFromViewController:oralVC toViewController:setVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            tfIsTop = !tfIsTop;

            
        }];
    
    }else{  //到首页
        self.text = @"口语练习";
        self.navigationItem.rightBarButtonItem = self.myTestBtn;
        self.navigationItem.leftBarButtonItem = self.headerIconV;

        [self transitionFromViewController:setVC toViewController:oralVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            tfIsTop = !tfIsTop;

            
        }];
    }
    
    
    
}

#pragma mark --备考信息更改
-(void)examInfoChange{
    
    NSLog(@"subject----%@",[UserDefaults valueForKey:subject]);
    [oralVC examInfoChange];
    [setVC examInfoChange];
}

//我的练习
-(void) myTestBtnClick{
#warning ---测试
    MyController *myVC = [[MyController alloc]init];
    [self.navigationController pushViewController:myVC animated:YES];
    return ;
    
    [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
//    [oralVC lianxi:nil];
}

//通知消息
-(void)noticeBtnClick{
    
}



@end
