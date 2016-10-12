//
//  SiftMachineController.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SiftMachineController.h"
#import "SiftCell.h"
#import "ClassMachineController.h"
#import "OtherClassMachineController.h"


#define CellUsr @"SiftCell"

@interface SiftMachineController (){
    
    IBOutlet UITableView *_tableView;
}

@end

@implementation SiftMachineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}

#pragma mark --子视图--
-(void)initViews{
    self.text = @"机经练习";
    [_tableView registerNib:[UINib nibWithNibName:@"SiftCell" bundle:nil] forCellReuseIdentifier:CellUsr];
    
}


#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
   
}




//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiftCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUsr forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[ClassMachineController alloc]init] animated:YES];

    }else{
        [self.navigationController pushViewController:[[OtherClassMachineController alloc]init] animated:YES];
 
    }
   
}

@end
