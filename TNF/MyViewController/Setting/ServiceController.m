//
//  ServiceController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "ServiceController.h"

#define cellUser @"serviceCell"
@interface ServiceController ()
{
    
    IBOutlet UITableView *_tableView;
    
}
@end

@implementation ServiceController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

-(void)initViews{
    self.text = @"在线客服";
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    _tableView.tableFooterView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = UIColor2(<#灰色背景#>);
        
        view;
    });
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellUser];
}


#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 0;
}


//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUser forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
