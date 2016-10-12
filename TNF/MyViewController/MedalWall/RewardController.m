//
//  RewardController.m
//  TNF
//
//  Created by wss on 16/5/11.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "RewardController.h"
#import "RewardCell.h"

#define CellUser @"RewardCell"
@interface RewardController ()
{
    
    IBOutlet UITableView *_tableView;
}
@end

@implementation RewardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    
}

-(void)initViews{
    self.text = @"奖励";
    [_tableView registerNib:[UINib nibWithNibName:@"RewardCell" bundle:nil] forCellReuseIdentifier:CellUser];
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return 4;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
