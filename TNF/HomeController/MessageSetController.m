//
//  MessageSetController.m
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MessageSetController.h"

#define CellUser @"setCell"
@interface MessageSetController ()
{
    
    IBOutlet UITableView *_tableView;
}
@end

@implementation MessageSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = @"消息设置";
    [self initViews];
}


#pragma mark --子视图
-(void)initViews{
    
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellUser];
    
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
}



//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    cell.textLabel.text = @"批改提醒";
    UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 60, 35)];
    switchBtn.tag = 1000 + indexPath.row;
    [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = switchBtn;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.contentView.height - 2, cell.contentView.width, 2)];
    label.backgroundColor = UIColor2(<#灰色背景#>);
    [cell.contentView addSubview:label];
    return cell;
}

-(void)switchBtnClick:(UISwitch*)switchBtn{
 
    NSLog(@"----点击row --- %d",(switchBtn.tag - 1000));
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
