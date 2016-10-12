//
//  CommentController.m
//  TNF
//
//  Created by wss on 16/4/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "CommentController.h"
#import "CommentCell.h"
#import "GrayStarView.h"

#define CellUser @"CommentCell"

@interface CommentController ()
{
    
    __weak IBOutlet UITableView *_tableView;
    
}
@end

@implementation CommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = @"评价";
    [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:CellUser];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self createHeaderView];
}

#pragma mark --请求完数据
-(void)createHeaderView{
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*ratioHeight)];
    headerV.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10*ratioWidth, 15*ratioHeight, kScreenWidth - 20*ratioHeight, 30*ratioHeight)];
    title.text = @"2016省考终极密卷下载专用";
    title.textColor = UIColorTitle;
    [headerV addSubview:title];
    
    //总评价
    StarView *startV = [[StarView alloc]initWithFrame:CGRectMake(title.left, title.bottom + 5*ratioHeight, 100*ratioWidth, 15*ratioHeight) starmore:3 Grayindex:5];
    [headerV addSubview:startV];
    
    UILabel *fenL = [[UILabel alloc]initWithFrame:CGRectMake(startV.right + 10*ratioWidth, startV.top, 40, startV.height)];
    fenL.text = @"8.8分";
    fenL.font = [UIFont systemFontOfSize:12];
    fenL.textColor = UIColorSubTitle;
    [headerV addSubview:fenL];
    
    UILabel *countL = [[UILabel alloc]initWithFrame:CGRectMake(fenL.right + 10*ratioWidth, fenL.top, 100, fenL.height)];
    countL.text = @"770个评分";
    countL.font = [UIFont systemFontOfSize:12];
    countL.textColor = UIColorSubTitle;
    [headerV addSubview:countL];
    
    //五列星星
    CGFloat starX = startV.left;
    CGFloat top = startV.bottom + 15*ratioHeight;
    CGFloat starWidth = startV.width;
    CGFloat height = 20*ratioHeight;
    CGFloat lineX = starX + starWidth + 15*ratioWidth;
    CGFloat lineWidth = (kScreenWidth - lineX - 10*ratioWidth);
    for (int i=0; i<5; i++) {
        //star
        GrayStarView *starView = [[GrayStarView alloc]initWithFrame:CGRectMake(starX, top + i*height, starWidth, height) starmore:4 Grayindex:5];
        [headerV addSubview:starView];
        //slider
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(lineX, starView.top, lineWidth, starView.height)];
        slider.userInteractionEnabled = NO;
        slider.minimumValue = 0;
        slider.maximumValue = 1;
        slider.value = 4.0/5;
        slider.minimumTrackTintColor = UIColor(<#深色背景#>);
        slider.maximumTrackTintColor = UIColor2(<#灰色背景#>);
        [slider setThumbImage:[UIImage imageNamed:@"clearBtnBg"] forState:UIControlStateNormal];
        [headerV addSubview:slider];
        
        
        
    }
    
    //线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headerV.height-5*ratioHeight, headerV.width, 5*ratioHeight)];
    line.backgroundColor = UIColor2(<#灰色背景#>);
    [headerV addSubview:line];
    _tableView.tableHeaderView = headerV;
    
}



#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 9;
}





//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
