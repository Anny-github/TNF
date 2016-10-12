//
//  TeacherController.m
//  TNF
//
//  Created by wss on 16/4/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TeacherController.h"
#import "CourseCell.h"
#import "CommentController.h"

#define CellUser @"courseCell"
@interface TeacherController ()<UITableViewDataSource,UITableViewDelegate>

{
    
    __weak IBOutlet UITableView *_tableView;
    
}
@end

@implementation TeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

-(void)initViews{
    
    self.text = @"李金鑫";
    [_tableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableView.tableHeaderView = self.tableHeaderView;
    
    _tableView.backgroundColor = UIColor2(<#灰色背景#>);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableView reloadData];
}


#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50*ratioHeight)];
    view.backgroundColor = UIColor2(<#灰色背景#>);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15*ratioHeight, kScreenWidth, 32*ratioHeight)];
    label.text = @"  历史课程";
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor whiteColor];
    [view addSubview:label];
    return view;
}
//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}



//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentController *vc = [[CommentController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
