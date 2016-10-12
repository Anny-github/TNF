//
//  PayController.m
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "PayController.h"
#import "PayCell.h"

#define CellUser @"payCell"
@interface PayController ()
{
    IBOutlet UIView *_tableHeaderView;
    
    IBOutlet UILabel *moneyL;
    IBOutlet UILabel *_descripLabel;
    
    IBOutlet UITableView *_tableView;
    
}
@end

@implementation PayController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
    
}
-(void)initViews{
    
    self.text = @"支付订单";
    [_tableView registerNib:[UINib nibWithNibName:@"PayCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableView.tableHeaderView = _tableHeaderView;
    _tableView.tableHeaderView.backgroundColor = UIColor2(<#灰色背景#>);
    _tableView.tableFooterView = ({
        
        UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        footV.backgroundColor = [UIColor clearColor];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40*ratioWidth, 30*ratioHeight, footV.width-80*ratioWidth, 50*ratioHeight)];
        btn.backgroundColor = UIColor1(<#蓝#>);
        [btn addTarget:self action:@selector(surePayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"确认充值" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        [footV addSubview:btn];
        footV;
        
    });
    
    _tableView.backgroundColor = UIColor2(<#灰色背景#>);
    
}


#pragma mark --确认支付
-(void)surePayBtnClick{
    
    
}
#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

//返回多少组表视图

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}



//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
