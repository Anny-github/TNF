//
//  MyAccountController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyAccountController.h"
#import "BillViewController.h"


#define CellUser @"AccountCell"
@interface MyAccountController ()
{
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation MyAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = @"我的账户";
    [self initViews];
}

-(void)initViews{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightBtn setTitle:@"账单" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(myBillBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellUser];
    _tableView.backgroundColor = UIColor2(<#灰色背景#>);
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    _tableView.tableFooterView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = UIColor2(<#灰色背景#>);
        view;
    });
}

//进入账单
-(void)myBillBtnClick{
    
    [self.navigationController pushViewController:[[BillViewController alloc]init] animated:YES];
}

#pragma mark --TableViewDelegate---


//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 45*ratioHeight;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"账户余额";
        UILabel *yueLabel = [cell.contentView viewWithTag:1000];
        if (yueLabel == nil) {
            yueLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 0, 90, 45)];
            yueLabel.text = @"￥100";
            yueLabel.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:yueLabel];
            yueLabel.tag = 1000;
            yueLabel.textColor = UIColorSubTitle;
            yueLabel.font = [UIFont systemFontOfSize:14];
        }
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"充值";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
