//
//  MyBuyCourseController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyBuyCourseController.h"
#import "BuyDetailCell.h"
#import "CourseDetailController.h"
#import "CommentController.h"
#import "LectureNoteController.h"


#define CellUser @"BuyDetailCell"
@interface MyBuyCourseController (){
    
    __weak IBOutlet UITableView *_tableView;
    
}

@end

@implementation MyBuyCourseController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

#pragma mark --子视图--
-(void)initViews{
    self.text = @"课程附讲义";
    
    UIButton *_downBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_downBtn setImage:[UIImage imageNamed:@"downBtnImg"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_downBtn];
    [_downBtn addTarget:self action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"BuyDetailCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark --下载
-(void)downBtnClick{
    
}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}



//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}


//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    
    
    
    __block typeof(self) weakSelf = self;
    cell.commentBtnClick = ^{
        CommentController *commentVC = [[CommentController alloc]init];
        [weakSelf.navigationController pushViewController:commentVC animated:YES];
    };
    
    cell.lectureBtnClick = ^{
        LectureNoteController *lectureVC = [[LectureNoteController alloc]init];
        [weakSelf.navigationController pushViewController:lectureVC animated:YES];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailController *vc = [[CourseDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
