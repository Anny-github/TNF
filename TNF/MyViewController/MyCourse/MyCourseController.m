//
//  MyCourseController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyCourseController.h"
#import "LXSgement.h"
#import "MyBuyCourseCell.h"
#import "Zhibocell.h"

#import "MyBuyCourseController.h"
#import "SelectDownController.h"

#define BuyCell @"BuyCell"
#define CollectCell @"CollectCell"
@interface MyCourseController ()<UITableViewDataSource,UITableViewDelegate,LXDelegate,UIScrollViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    UIScrollView *_scrollV;
    UITableView *_downTableV;
    UITableView *_collectTableV;
    LXSgement *_segment;
}

@end

@implementation MyCourseController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.text = @"我的课程";
    [self initViews];
}


-(void)initViews{
    
    
    UIButton *_downBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_downBtn setImage:[UIImage imageNamed:@"downBtnImg"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_downBtn];
    [_downBtn addTarget:self action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _segment = [[LXSgement alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 40*ratioHeight) titles:@[@"已购买",@"已收藏"] normalColor:[UIColor blackColor] selectedColor:UIColor1(蓝) bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
    _segment.delegate = self;
    _segment.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segment];
    
    
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _segment.bottom, kScreenWidth, kScreenHeight-_segment.bottom - 64)];
    _scrollV.delegate = self;
    _scrollV.pagingEnabled = YES;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollV];
    _scrollV.contentSize = CGSizeMake(2*kScreenWidth, 0);
    
    
    
    //tableView
    _downTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _scrollV.height) style:UITableViewStyleGrouped];
    _downTableV.delegate = self;
    _downTableV.dataSource = self;
    [_downTableV registerNib:[UINib nibWithNibName:@"MyBuyCourseCell" bundle:nil] forCellReuseIdentifier:BuyCell];
    [_downTableV registerNib:[UINib nibWithNibName:@"ZhiBoCell" bundle:nil] forCellReuseIdentifier:CollectCell];
    [_scrollV addSubview:_downTableV];
    
    _collectTableV = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollV.height) style:UITableViewStyleGrouped];
    [_collectTableV registerNib:[UINib nibWithNibName:@"MyBuyCourseCell" bundle:nil] forCellReuseIdentifier:BuyCell];
    _collectTableV.delegate = self;
    _collectTableV.dataSource = self;
    [_scrollV addSubview:_collectTableV];

    
    
    //搜索 headerV
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = [MyColor colorWithHexString:@"d9d9db"];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15*ratioWidth, 5*ratioHeight, headerView.width - 30*ratioWidth, 35*ratioHeight)];
    [searchBar setBackgroundImage:[[UIImage imageNamed:@"searchBg"] stretchableImageWithLeftCapWidth:100 topCapHeight:0]];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    [headerView addSubview:searchBar];
    searchBar.centerY = headerView.height/2.0;
    _downTableV.tableHeaderView =  headerView;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:headerView];
    _collectTableV.tableHeaderView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.view setNeedsDisplay];
}

-(void)downBtnClick{
    
    [self.navigationController pushViewController:[[SelectDownController alloc]init] animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _scrollV) {
        NSInteger index = (scrollView.contentOffset.x + kScreenWidth/2.0)/kScreenWidth;
        [_segment selectedIndex:index];
    }
    
}

#pragma mark --LXSegmentDelegate--
-(void)clickindex:(int)index{
    
    [_scrollV setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _downTableV) {
        if (section == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*ratioHeight)];
            label.backgroundColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [MyColor colorWithHexString:@"0xd9d9db"];
            label.text = @" 回放列表(9堂)";
            return label;
        }else {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*ratioHeight)];
            label.backgroundColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [MyColor colorWithHexString:@"0xd9d9db"];
            label.text = @" 待直播列表";
            return label;
        }
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _downTableV) {
        return 40*ratioHeight;

    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == _downTableV) {
        if (indexPath.section == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:BuyCell
                                                               forIndexPath:indexPath];
        }else if (indexPath.section == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:CollectCell forIndexPath:indexPath];
        }
    }else if (tableView == _collectTableV){
        cell = [tableView dequeueReusableCellWithIdentifier:BuyCell forIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _downTableV) {
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:[[MyBuyCourseController alloc]init] animated:YES];
        }
    }
    
}


#pragma mark --SearchBar Event--
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //搜索
    [textField resignFirstResponder];
    return YES;
}

@end
