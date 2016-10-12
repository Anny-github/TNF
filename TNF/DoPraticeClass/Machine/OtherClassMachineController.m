//
//  OtherClassMachineController.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "OtherClassMachineController.h"
#import "HeaderViewDate.h"
#import "OtherMachineCell.h"


#define CellUser @"OtherMachineCell"

@interface OtherClassMachineController (){
    
    IBOutlet UITableView *_tableView;
    HeaderViewDate *_headerView;
}

@end

@implementation OtherClassMachineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OtherMachineCell" bundle:nil] forCellReuseIdentifier:CellUser];
    
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}
//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
}

//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[HeaderViewDate alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50*ratioHeight)];
    _headerView.text1 = @"已练34题/共98题";
    _headerView.backgroundColor = [MyColor colorWithHexString:@"f2f2f2"];
    return _headerView;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50*ratioHeight;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherMachineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
