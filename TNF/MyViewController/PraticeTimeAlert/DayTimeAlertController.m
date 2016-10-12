//
//  DayTimeAlertController.m
//  TNF
//
//  Created by dongliwei on 16/4/15.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "DayTimeAlertController.h"
#import "DayTimeAlertCell.h"
#import "ClockTimeView.h"
#import <MapKit/MapKit.h>
#import "JPUSHService.h"

#define CellIden @"TimeCell"
@interface DayTimeAlertController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableV;
    NSMutableArray *_timeArr;
    
}
@end

@implementation DayTimeAlertController

//时间本地路径
-(NSString*)timeArrPath{
    NSString *home = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [home stringByAppendingPathComponent:@"timeArr.plist"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}




#pragma makr --初始化view-
-(void)initView{
    
    self.text = @"每日答题提醒";
    _tableV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view addSubview:_tableV];
    [_tableV registerClass:[DayTimeAlertCell class] forCellReuseIdentifier:CellIden];
    
    //rightItem
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    
    _timeArr = [NSMutableArray arrayWithContentsOfFile:[self timeArrPath]];
    if (_timeArr.count == 0) {
        //安全起见
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        NSMutableDictionary *timeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"22:30",@"datetime",@"0",@"is_open", nil];
        _timeArr = [NSMutableArray arrayWithObjects:timeDic, nil];
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    [_timeArr writeToFile:[self timeArrPath] atomically:YES];
    
//    NSDictionary *param = @{@"member_id":[UserDefaults objectForKey:Userid],@"info":[_timeArr JSONString]} ;
//    
//    [WXDataService requestAFWithURL:Url_setTimeAlert params:param httpMethod:@"POST" finishBlock:^(id result) {
//        
//        NSLog(@"result=------%@",result);
//        
//    } errorBlock:^(NSError *error) {
//        NSLog(@"-----error------%@",error);
//
//    }];
}

#pragma mark --添加闹钟--
-(void)addBtnClick:(UIButton*)button{
    
    ClockTimeView *timeV = [[ClockTimeView alloc]init];
    [timeV showWithTime:nil isOn: YES];
    
    timeV.selectedTime = ^(NSString *time,BOOL onOff){
        //已经有该时间
        for (NSMutableDictionary *timeDic in _timeArr) {
            if ([time isEqualToString:timeDic[@"datetime"]]) {
                [timeDic setValue:@"1" forKey:@"is_open"];
                [_tableV reloadData];
                [_timeArr writeToFile:[self timeArrPath] atomically:YES];

                return ;
            }
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (onOff) {
    
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"is_open",time,@"datetime",nil];
            
        }else{
            
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"is_open",time,@"datetime",nil];
        }
        
        [_timeArr addObject:dic];
        [_tableV reloadData];
        [_timeArr writeToFile:[self timeArrPath] atomically:YES];

     };
}


#pragma mark --UITableViewDelegate----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _timeArr.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DayTimeAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIden forIndexPath:indexPath];
    
    cell.timeDic = _timeArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //switch
    cell.timeisOn = ^(BOOL isOn){
        if (isOn == YES) { //开启
            [_timeArr[indexPath.row] setValue:@"1" forKey:@"is_open"];
        }else{
            [_timeArr[indexPath.row] setValue:@"0" forKey:@"is_open"];

        }
        [_tableV reloadData];
        [_timeArr writeToFile:[self timeArrPath] atomically:YES];

        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *time = _timeArr[indexPath.row];
    ClockTimeView *timeV = [[ClockTimeView alloc]init];
    [timeV showWithTime:time[@"datetime"] isOn:YES];
    
    timeV.selectedTime = ^(NSString *time,BOOL onOff){
        
        if (onOff == YES) { //开启
            [_timeArr[indexPath.row] setValue:@"1" forKey:@"is_open"];
            [_timeArr[indexPath.row] setValue:time forKey:@"datetime"];
            [_tableV reloadData];
            
        }
        [_timeArr writeToFile:[self timeArrPath] atomically:YES];

    };

    
}

#pragma mark --删除cell
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        
        NSDictionary *time = _timeArr[indexPath.row];
        
        //删除通知
        NSArray *notification = [[UIApplication sharedApplication]scheduledLocalNotifications];
        for (UILocalNotification *nofi in notification) {
            
            if ([nofi.userInfo[@"time"] isEqualToString:time[@"datetime"]]) {
        
                [[UIApplication sharedApplication]cancelLocalNotification:nofi];
                
            }
            
        }

        [_timeArr removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
        [_timeArr writeToFile:[self timeArrPath] atomically:YES];
        
    }
}

@end
