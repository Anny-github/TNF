//
//  NotificationController.m
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "NotificationController.h"
#import "NotificationCell.h"
#import "MessageSetController.h"

#define CellUser @"NotificationCell"
@interface NotificationController ()
{
    
    IBOutlet UITableView *_tableVIew;
}
@end

@implementation NotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text = @"消息中心";
    [self initViews];
}


#pragma mark --子视图
-(void)initViews{
    [_tableVIew registerNib:[UINib nibWithNibName:@"NotificationCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableVIew.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [setBtn setImage:[UIImage imageNamed:@"set_right"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
    setBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    
}

-(void)setBtnCLick{
    
    [self.navigationController pushViewController:[[MessageSetController alloc]init] animated:YES];
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
}



//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor2(<#灰色背景#>);
    cell.contentView.backgroundColor = UIColor2(<#灰色背景#>);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
