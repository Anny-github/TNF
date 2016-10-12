//
//  SelectDownController.m
//  TNF
//
//  Created by wss on 16/4/27.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SelectDownController.h"
#import "SelectDownCell.h"

#define CellUser @"downCell"

@interface SelectDownController (){
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation SelectDownController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_tableView registerNib:[UINib nibWithNibName:@"SelectDownCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
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
    return 5;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectDownCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
