//
//  CourseDetailController.m
//  TNF
//
//  Created by wss on 16/4/27.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "CourseDetailController.h"
#import "TeacherCell.h"
#import "TeacherController.h"


#define SegHeight 40*ratioHeight
#define BottomHeight 50*ratioHeight



#define CellUser @"teachCell"
@interface CourseDetailController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,LXDelegate,UIWebViewDelegate>
{
    UIView *_topView;
    UIScrollView *_bgScrollV;
    UIWebView *_firstView;
    UIWebView *_secondView;
    UITableView *_thirdView;
    LXSgement *_segment;
    UIView *_bottomV;
    
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_moneyLabel;
    UILabel *_stopSaleDay;
    UILabel *_peopleNumL;

}

@end

@implementation CourseDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _bottomV.top = self.view.height - BottomHeight;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    [self initViews];
    [self loadData];
}
#pragma mark --加载数据
-(void)loadData{
    [_firstView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [_secondView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];

}

#pragma mark ----子视图
-(void)initViews{
    
    self.text = @"课程详情";
    [self initTopView];
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 ,50, 50)];
    [rightBtn setImage:[UIImage imageNamed:@"collectBtnImg"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _bgScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topView.bottom + 10*ratioHeight, kScreenWidth, self.view.height - _topView.bottom - 45*ratioHeight - 64)];
    _bgScrollV.backgroundColor = [UIColor clearColor];
    _bgScrollV.showsVerticalScrollIndicator = NO;
    _bgScrollV.showsHorizontalScrollIndicator = NO;
    _bgScrollV.contentSize = CGSizeMake(3*kScreenWidth, 0);
    _bgScrollV.delegate = self;
    _bgScrollV.pagingEnabled = YES;
    [self.view addSubview:_bgScrollV];
    
    
    //三个子view
    _firstView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _bgScrollV.height)];
    _firstView.scrollView.delegate = self;
    _firstView.scrollView.bounces = NO;
    [_bgScrollV addSubview:_firstView];
    
    _secondView = [[UIWebView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _bgScrollV.height)];
    _secondView.scrollView.delegate = self;
    _secondView.scrollView.bounces = NO;
    [_bgScrollV addSubview:_secondView];
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, _bgScrollV.height) style:UITableViewStyleGrouped];
    _thirdView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    _thirdView.delegate = self;
    _thirdView.dataSource = self;
    [_thirdView registerNib:[UINib nibWithNibName:@"TeacherCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _thirdView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgScrollV addSubview:_thirdView];
    
    
    //bottomVIew
    _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - BottomHeight, kScreenWidth, BottomHeight)];
    _bottomV.backgroundColor = [UIColor whiteColor];
    //线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bottomV.width, 1)];
    line.backgroundColor = UIColor2(<#灰色背景#>);
    [_bottomV addSubview:line];
    [self.view addSubview:_bottomV];
    _moneyLabel = [WXLabel UIlabelFrame:CGRectMake(0, 0, 80, _bottomV.height) textColor:UIColor8(<#橘黄#>) textFont:[UIFont systemFontOfSize:30] labelTag:0];
    _moneyLabel.text = @"199";
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomV addSubview:_moneyLabel];
    UILabel *stopL = [[UILabel alloc]initWithFrame:CGRectMake(_moneyLabel.right + 5*ratioWidth, 10*ratioHeight, 55, _bottomV.height/2.0-10*ratioHeight)];
    stopL.text = @"距离停售";
    stopL.textColor = UIColorSubTitle;
    stopL.font = [UIFont systemFontOfSize:13];
    [_bottomV addSubview:stopL];
    _stopSaleDay = [WXLabel UIlabelFrame:CGRectMake(stopL.right, stopL.top, 100, stopL.height) textColor:UIColor8(<#橘黄#>) textFont:[UIFont systemFontOfSize:13] labelTag:1000];
    _stopSaleDay.text = @"8天";
    [_bottomV addSubview:_stopSaleDay];
    
    _peopleNumL = [[UILabel alloc]initWithFrame:CGRectMake(stopL.left, _bottomV.height/2.0, 180, _bottomV.height/2.0-10*ratioHeight)];
    _peopleNumL.font = [UIFont systemFontOfSize:14];
    _peopleNumL.textColor = UIColorSubTitle;
    _peopleNumL.text = @"已有595人购买";
    [_bottomV addSubview:_peopleNumL];
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomV.width - 90*ratioWidth, 10*ratioHeight, 70*ratioWidth, _bottomV.height - 20*ratioHeight)];
    [buyBtn setImage:[UIImage imageNamed:@"buyBtnImg"] forState:UIControlStateNormal];
    [_bottomV addSubview:buyBtn];
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];


    
}

#pragma mark --initTopView--
-(void)initTopView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130*ratioHeight)];
    _topView.backgroundColor = UIColor2(<#灰色背景#>);
    [self.view addSubview:_topView];
    
    //
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 10*ratioHeight, kScreenWidth, 70*ratioHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:titleView];
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.height-0.5, titleView.width, 0.5)];
    bottomLine.backgroundColor = UIColor2(<#灰色背景#>);
    [titleView addSubview:bottomLine];
    
    _titleLabel = [WXLabel UIlabelFrame:CGRectMake(10*ratioWidth, titleView.height/2.0-20*ratioHeight, _topView.width - 70*ratioWidth, 20*ratioHeight) textColor:UIColorTitle textFont:[UIFont systemFontOfSize:18] labelTag:100];
    _titleLabel.text = @"事业单位-公基系统班：6班";
    [titleView addSubview:_titleLabel];
    
    //line
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(_topView.width-50*ratioWidth-1, 0, 1, 50*ratioHeight)];
    line.backgroundColor = [UIColor lightGrayColor];
//    [titleView addSubview:line];
    
    UIButton *consultBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleView.width-50*ratioWidth-10*ratioWidth, 0 ,50*ratioWidth, 50*ratioHeight)];
    [consultBtn setImage:[UIImage imageNamed:@"consult"] forState:UIControlStateNormal];
    [titleView addSubview:consultBtn];
    [consultBtn addTarget:self action:@selector(consultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleView.height/2.0 , 30, 30)];
    timeImg.image = [UIImage imageNamed:@"timeIcon"];
    timeImg.contentMode = UIViewContentModeCenter;
    [titleView addSubview:timeImg];
    _timeLabel = [WXLabel UIlabelFrame:CGRectMake(timeImg.right, timeImg.top, titleView.width - 100*ratioWidth, 30) textColor:UIColorSubTitle textFont:[UIFont systemFontOfSize:13] labelTag:101];
    _timeLabel.text = @"2016.4.29 - 2016.5.19(112课时)";
    [titleView addSubview:_timeLabel];
    
    //LXSgement
    _segment = [[LXSgement alloc]initWithFrame:CGRectMake(0, titleView.bottom + 10*ratioHeight, kScreenWidth, 40 * ratioHeight) titles:@[@"课程介绍",@"课程表",@"老师介绍"] normalColor:[UIColor blackColor] selectedColor:UIColor1(蓝) bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
    [_topView addSubview:_segment];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.delegate = self;

}

#pragma mark --切换
-(void)clickindex:(int)index{
    [_bgScrollV setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _bgScrollV) {
        [_segment selectedIndex:(scrollView.contentOffset.x+kScreenWidth/2.0)/kScreenWidth];
        

    }else if (scrollView == _firstView.scrollView || scrollView == _secondView.scrollView){
        if (scrollView.contentOffset.y > 10 && _topView.top == 0) { //说明需要隐藏
            [self hiddenTop];
        }else if (scrollView.contentOffset.y < 10 && _topView.top < 0){
            //需要出现
            [self appearTop];
        }
        
    }else if (scrollView == _thirdView){ //tableView起初的contentOffset的Y就是30
        if (scrollView.contentOffset.y > 40 && _topView.top == 0) { //说明需要隐藏
            [self hiddenTop];
        }else if (scrollView.contentOffset.y < 30  && _topView.top < 0){
            //需要出现
            [self appearTop];
        }
    }
}

-(void)hiddenTop{
    [UIView animateWithDuration:0.3 animations:^{
        _topView.top = -(_topView.height - _segment.height);
        _bgScrollV.top = _topView.bottom;
        _bgScrollV.height = self.view.height - _segment.height - _bottomV.height;
        _firstView.height = _bgScrollV.height;
        _secondView.height = _bgScrollV.height;
        _thirdView.height = _bgScrollV.height;
        _bottomV.top = self.view.height - BottomHeight;
    }];
    
    
}
-(void)appearTop{
    [UIView animateWithDuration:0.3 animations:^{
        _topView.top = 0;
        _bgScrollV.top = _topView.bottom;
        _bgScrollV.height = self.view.height - _topView.height - _bottomV.height;
        _firstView.height = _bgScrollV.height;
        _secondView.height = _bgScrollV.height;
        _thirdView.height = _bgScrollV.height;
        _bottomV.top = self.view.height - BottomHeight;
    }];
    
    
}
#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进入老师详情
    TeacherController *teachVC = [[TeacherController alloc]init];
    TeacherCell *cell = [tableView cellForRowAtIndexPath:indexPath ];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cell];
    teachVC.tableHeaderView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.navigationController pushViewController:teachVC animated:YES];
    [_thirdView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark --收藏--
-(void)collectBtnClick{
    
}

#pragma mark --咨询--
-(void)consultBtnClick{
    
}


#pragma mark --购买
-(void)buyBtnClick{
    
    
}
@end
