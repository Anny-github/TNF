//
//  VoiceCollectController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoiceCollectController.h"
#import "VoiceCollectCell.h"


#define CellUser @"CollectCell"
@interface VoiceCollectController (){
    
    __weak IBOutlet UITableView *_tableView;
    UILabel *zongshulabel;
}

@end

@implementation VoiceCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = @"录音收藏";
    [self initViews];
}

-(void)initViews{
    [_tableView registerNib:[UINib nibWithNibName:@"VoiceCollectCell" bundle:nil] forCellReuseIdentifier:CellUser];
    
    _tableView.tableHeaderView = ({
        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,45 )];
        bjview.backgroundColor = [UIColor clearColor];
        
        //一共多少个录音
        zongshulabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (45 -20 * ratioWidth) / 2.0 , kScreenWidth, 20 * ratioWidth)];
        zongshulabel.textColor = UIColor6(正文小字);
        zongshulabel.textAlignment = NSTextAlignmentCenter;
        zongshulabel.font = [UIFont systemFontOfSize:17*ratioWidth];
        zongshulabel.text = @"共16个录音";
        [bjview addSubview:zongshulabel];
        bjview;
        
    });

}

#pragma mark --TableViewDelegate---

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    NSArray *toushus = _DataKeyArray;
    //组视图背景视图
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenWidth, 30*ratioHeight);
    view.backgroundColor = UIColor2(灰色背景);
    
    //组视图label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200*ratioHeight, 20*ratioHeight)];
    label.textColor = UIColor6(正文小字);
    label.font = [UIFont systemFontOfSize:13*ratioHeight];
    label.text = @"2016.05.01";
    [view addSubview:label];
    
    return view;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return 5;
}



//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VoiceCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
