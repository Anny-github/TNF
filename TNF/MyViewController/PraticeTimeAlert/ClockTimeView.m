//
//  ClockTimeView.m
//  TNF
//
//  Created by dongliwei on 16/4/15.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "ClockTimeView.h"

@interface ClockTimeView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_hourArr;
    NSMutableArray *_minuteArr;
    CGFloat pickerWith;
    UICollectionView *_hourView;
    UICollectionView *_miniteView;
    NSIndexPath *_hourSelectedIndexPath;
    NSIndexPath *_minuteSelectedIndexPath;
    CGFloat cellHeight;
    CGFloat collectionViewHeight;
    
    //开启按钮
    UIButton *voiceBtn;
    
    //坐标系view
    UIView *firstV;
    UIView *secondV;
    
    //新加提醒开启或关闭
    BOOL isAlert;
}

@end

@implementation ClockTimeView
-(instancetype)init{
    if (self = [super init]) {
        [self initValues];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initValues];
    }
    return self;
}
-(void)initValues{
    
    isAlert = YES; //默认开启提醒
    _hourArr = [NSMutableArray array];
    NSArray *arr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    for (int i=0; i<500; i++) {
        [_hourArr addObjectsFromArray:arr];
    }
    _minuteArr = [NSMutableArray array];
    NSArray *arr1 = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    for (int i=0; i<500; i++) {
        [_minuteArr addObjectsFromArray:arr1];
    }

}

-(void)showWithTime:(NSString *)time isOn:(BOOL)isOn{
   
    [self initViews];
    
    [kWindow addSubview:self];

    if (time == nil || time.length == 0) {
        _hourSelectedIndexPath = [NSIndexPath indexPathForItem:12 inSection:0];
        _minuteSelectedIndexPath = [NSIndexPath indexPathForItem:30 inSection:0];
        
     }else{
        //如 time = @"12:40"
        NSArray *timearr = [time componentsSeparatedByString:@":"];
        _hourSelectedIndexPath = [NSIndexPath indexPathForItem:[_hourArr indexOfObject:timearr[0]] inSection:0];
        _minuteSelectedIndexPath = [NSIndexPath indexPathForItem:[_minuteArr indexOfObject:timearr[1]] inSection:0];
    }
    
    [_hourView setContentOffset:CGPointMake(0, _hourSelectedIndexPath.row*cellHeight-cellHeight/2.0) animated:NO];

    [_miniteView setContentOffset:CGPointMake(0, _minuteSelectedIndexPath.row*cellHeight-cellHeight/2.0) animated:NO];

    
    if (isOn == NO) {
        isAlert = NO;
        [voiceBtn setTitleColor:UIColor4(<#所有的灰色#>) forState:UIControlStateNormal];
        
        
    }

}

#pragma mark
-(void)initViews{
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    //whiteView 正方形
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(20*ratioWidth, 150*ratioHeight, kScreenWidth - 2*20*ratioWidth, kScreenWidth - 2*20*ratioWidth)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    
    //title
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*ratioHeight, bgView.width, 15)];
    titleL.text = @"设置答题提醒时间";
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleL];
    
    //线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, titleL.bottom + 10*ratioHeight, bgView.width, 0.5)];
    line.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [bgView addSubview:line];
    
    //取消，确定按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, bgView.height - 40*ratioHeight, bgView.width/2.0-0.5, 40*ratioHeight)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor1(蓝) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1000;
    [bgView addSubview:cancelBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(cancelBtn.right+1, bgView.height - 40*ratioHeight, bgView.width/2.0-0.5, 40*ratioHeight)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:UIColor1(<#蓝#>) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag = 1001;
    [bgView addSubview:sureBtn];
    //线
    UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(cancelBtn.right, cancelBtn.top, 1, cancelBtn.height)];
    verticalLine.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [bgView addSubview:verticalLine];
    
    UIView *horiLine = [[UIView alloc]initWithFrame:CGRectMake(0, cancelBtn.top-0.5, bgView.width, 0.5)];
    horiLine.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [bgView addSubview:horiLine];
    
    //铃声开启否 btn
    voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, horiLine.top - 15*ratioHeight-40*ratioHeight, bgView.width/2.0+10*ratioWidth, 35*ratioHeight)];
    [voiceBtn setTitle:@"提醒铃声开启" forState:UIControlStateNormal];
    [voiceBtn setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateSelected];
    [voiceBtn setImage:[UIImage imageNamed:@"clock_gray"] forState:UIControlStateNormal];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg"] forState:UIControlStateSelected];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg_gray"] forState:UIControlStateNormal];
    voiceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [voiceBtn setTitleColor:UIColor1(蓝) forState:UIControlStateSelected];
    [voiceBtn setTitleColor:[MyColor colorWithHexString:@"0xBDBDBD"] forState:UIControlStateNormal];
  
    
    [voiceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    voiceBtn.tag = 1002;
    [bgView addSubview:voiceBtn];
    voiceBtn.centerX = bgView.width/2.0;
    voiceBtn.selected = YES;
    [voiceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];

    
    //timePicker  CGRectMake(voiceBtn.left, line.bottom+10*ratioHeight, voiceBtn.width, voiceBtn.top - 10*ratioHeight - line.bottom - 10*ratioHeight)
  
    cellHeight = (voiceBtn.width/2.0-10)*1.5/2.0;
    //collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(voiceBtn.width/2.0-10-10, cellHeight);

    _hourView = [[UICollectionView alloc]initWithFrame:CGRectMake(voiceBtn.left, line.bottom+10*ratioHeight, voiceBtn.width/2.0-10, (voiceBtn.width/2.0-10)*1.5) collectionViewLayout:layout];
    _hourView.centerY = line.bottom + (voiceBtn.top - line.bottom)/2.0;
    _hourView.backgroundColor = UIColor2(<#灰色背景#>);
    _hourView.dataSource = self;
    _hourView.delegate = self;
    _hourView.bounces = NO;
    [_hourView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"hourCell"];
    [bgView addSubview:_hourView];
    _hourView.showsVerticalScrollIndicator = NO;
    
    //:
    UILabel *point = [[UILabel alloc]initWithFrame:CGRectMake(_hourView.right, _hourView.centerY, 10, 40)];
    point.text = @":";
    point.font = [UIFont boldSystemFontOfSize:30];
    point.textColor = UIColor1(<#蓝#>);
    [bgView addSubview:point];
    point.centerX = bgView.width/2.0;
    point.centerY = _hourView.centerY;
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc]init];
    layout1.itemSize = CGSizeMake(voiceBtn.width/2.0-10-10, cellHeight);
    layout1.minimumLineSpacing = 0;
    layout1.minimumInteritemSpacing = 0;
    _miniteView = [[UICollectionView alloc]initWithFrame:CGRectMake(voiceBtn.centerX+10, line.bottom+10*ratioHeight, voiceBtn.width/2.0-10, _hourView.height) collectionViewLayout:layout1];
    _miniteView.centerY = _hourView.centerY;
    _miniteView.backgroundColor = UIColor2(<#灰色背景#>);
    _miniteView.dataSource = self;
    _miniteView.delegate = self;
    _miniteView.bounces = NO;
    [bgView addSubview:_miniteView];
    [_miniteView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"minuteCell"];

    _miniteView.showsVerticalScrollIndicator = NO;
    
    collectionViewHeight = _hourView.height;
  

    //转换坐标系用
    firstV = [[UIView alloc]initWithFrame:_hourView.frame];
    secondV = [[UIView alloc]initWithFrame:_miniteView.frame];
    [bgView insertSubview:firstV belowSubview:_hourView];
    [bgView insertSubview:secondV belowSubview:_miniteView];
    firstV.backgroundColor = [UIColor clearColor];
    secondV.backgroundColor = [UIColor clearColor];
    firstV.userInteractionEnabled = NO;
    secondV.userInteractionEnabled = NO;
    
    [_hourView reloadData];
    [_miniteView reloadData];
    
}

#pragma mark --按钮点击--
-(void)btnClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    
    if (btn.tag == 1000) { //取消
        [self removeFromSuperview];
        
    }else if (btn.tag == 1001){  //确定
        isAlert = YES;
        [self calculateTime];
        
        
    }else if(btn.tag == 1002){  //声音开关
        isAlert = !isAlert;
        

    }
    
}

//计算时间--
-(void)calculateTime{
    //取中
    UICollectionViewCell *centerCell = [self centerCell:[_hourView visibleCells]];
    UILabel *label = [centerCell.contentView viewWithTag:1000];
    NSString *hour = label.text;
    
    //minute
    UICollectionViewCell *centerCell2 = [self centerCell:[_miniteView visibleCells]];
    UILabel *label2 = [centerCell2.contentView viewWithTag:1001];
    NSString *minute = label2.text;
    NSLog(@"hour:numte---------%@:%@",hour,minute);
    
    if (isAlert) {
        [self addLocalPush:[NSString stringWithFormat:@"%@:%@",hour,minute] isOn:YES];

    }
    
    [self removeFromSuperview];
    
}


//取中间的cell
-(UICollectionViewCell*)centerCell:(NSArray*)cells{
    NSArray *cellArray;
    cellArray = [cells sortedArrayUsingComparator:^NSComparisonResult(UICollectionViewCell *obj1,UICollectionViewCell *obj2) {
        if (obj1.top > obj2.top) {
            return NSOrderedDescending;
        }
        
        if (obj1.top > obj2.top) {
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    return cellArray[1];
}
#pragma makr --添加通知--
-(void)addLocalPush:(NSString*)time isOn:(BOOL)isOn{
    
    //所有已开启的推送
    NSArray *notification = [[UIApplication sharedApplication]scheduledLocalNotifications];
    
    for (UILocalNotification *nofi in notification) {
        if ([nofi.userInfo[@"time"] isEqualToString:time]) {
            //此时间开启过
            if (isOn == YES) {
                return;
            }else if (isOn == NO){  //要关闭
                [[UIApplication sharedApplication]cancelLocalNotification:nofi];
            }
        }
    }
    
    //开启
    UILocalNotification *newNofi=[[UILocalNotification alloc] init];
    if (newNofi != nil) {
        newNofi.fireDate= [TNFPublicTool fireDate:time];
        newNofi.timeZone=[NSTimeZone defaultTimeZone];
        newNofi.alertBody=@"口语医生提醒您,练习时间到了！";
        newNofi.soundName = UILocalNotificationDefaultSoundName;
        newNofi.repeatInterval = NSCalendarUnitDay;
        newNofi.userInfo = @{@"time":time};
        [[UIApplication sharedApplication] scheduleLocalNotification:newNofi];
    
        self.selectedTime(time,YES);

        
    }
        
}

#pragma mark --根据time计算fireDate
-(NSDate*)fireDate:(NSString*)time{
    
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];

    NSCalendar *calendar = [NSCalendar currentCalendar]; //今日
    NSDateComponents *comp1  = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    
    NSInteger year = comp1.year;
    NSString *month = (comp1.month / 10) > 0? [NSString stringWithFormat:@"%d",comp1.month] : [NSString stringWithFormat:@"0%d",comp1.month];
    NSString *day = (comp1.day / 10) > 0 ? [NSString stringWithFormat:@"%d",comp1.day] : [NSString stringWithFormat:@"0%d",comp1.day];
    
    NSString *dateStr = [NSString stringWithFormat:@"%d-%@-%@ %@",year,month,day,time];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeZone = [NSTimeZone localTimeZone];
    [format setDateFormat:@"YYYY-MM-DD HH:mm"];
    return [format dateFromString:dateStr];
    
}

#pragma mark --UIColelctionViewDelegate--
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _hourView) {
        return _hourArr.count;
    }else{
        return _minuteArr.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _hourView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hourCell" forIndexPath:indexPath];
        UILabel *label = [cell.contentView viewWithTag:1000];
        if (!label) {
            label = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:35];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView insertSubview:label atIndex:0];
            label.tag = 1000;
        }
        if (_hourSelectedIndexPath.row == indexPath.row) {
            label.textColor = UIColor1(<#蓝#>);
        }else{
            label.textColor = [MyColor colorWithHexString:@"0xA2C4EE"];;
        }
        
        label.text = @"";

        label.text = _hourArr[indexPath.row];
        return cell;
        
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"minuteCell" forIndexPath:indexPath];
        UILabel *label = [cell.contentView viewWithTag:1001];
        if (!label) {
            label = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:35];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = 1001;
            [cell.contentView insertSubview:label atIndex:0];
        }
        
        if (_minuteSelectedIndexPath.row == indexPath.row) {
            label.textColor = UIColor1(<#蓝#>);
        }else{
            label.textColor = [MyColor colorWithHexString:@"0xA2C4EE"];;
        }
        
        label.text = @"";
        label.text = _minuteArr[indexPath.row];
        return cell;
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self changeCellToCenter:collectionView];
    [self changeCellTextColorWithcollectionView:collectionView];
}



#pragma mark --滑动减速 -控制cell显示中间
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"--de---%f",scrollView.decelerationRate);
    
    if (scrollView.decelerationRate < 1.0) {
        [self changeCellToCenter:scrollView];
//    
//        UICollectionView *collectionView = (UICollectionView*)scrollView;
//        [self changeCellTextColorWithcollectionView:collectionView];
    }


}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {  //不会走减速方法 scrollViewDidEndDecelerating
        [self changeCellToCenter:scrollView];
        UICollectionView *collectionView = (UICollectionView*)scrollView;

        [self changeCellTextColorWithcollectionView:collectionView];
    }
}


#pragma mark -- 使cell显示在中间，当拖拽结束不减速，或滑动结束减速时
-(void)changeCellToCenter:(UIScrollView*)scrollView{
    
    UICollectionView *collectionV = (UICollectionView*)scrollView;
    CGPoint contentOffset = scrollView.contentOffset;
    int x = ((int)contentOffset.y % (int)cellHeight);
    int x1 = contentOffset.y /cellHeight;
    if (x == 0) { //
        contentOffset.y += (scrollView.height-cellHeight)/2.0;
    }else{
        //错开的高度
        CGFloat h = cellHeight/2.0;
        contentOffset.y = x1*cellHeight + h;
        
        if (collectionV.visibleCells.count < 3) {
            
            contentOffset.y = x1*cellHeight + 2*h;

        }

    }

    [scrollView setContentOffset:contentOffset animated:YES];
}


#pragma mark -- 滑动中改变颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UICollectionView *collectionView = (UICollectionView*)scrollView;

    [self changeCellTextColorWithcollectionView:collectionView];
    
    
}

//坐标系转换，获取中间的cell
-(void)changeCellTextColorWithcollectionView:(UICollectionView *)collectionView{
    
    NSArray *cells = [collectionView visibleCells];
    
    for (UICollectionViewCell *cell in cells) {
        //转换坐标系
        CGRect cellFrame = cell.frame;
        CGRect newFrame;
        if (collectionView == _hourView) {
            newFrame = [cell.superview convertRect:cellFrame toView:firstV];
        }else if (collectionView == _miniteView){
            newFrame = [cell.superview convertRect:cellFrame toView:secondV];

        }
        
        UIView *frameV = [[UIView alloc]initWithFrame:newFrame];
        if (collectionView == _hourView) {
            //取label
            UILabel *label = [cell.contentView viewWithTag:1000];
            if(frameV.top <= collectionViewHeight/2.0 && frameV.top > 0){
                //蓝色
                _hourSelectedIndexPath = [collectionView indexPathForCell:cell];
                label.textColor = UIColor1(<#蓝#>);
                
            }else{
                label.textColor = [MyColor colorWithHexString:@"0xA2C4EE"];;
            }
            
        }else if (collectionView == _miniteView){
            //取label
            UILabel *label = [cell.contentView viewWithTag:1001];
            if(frameV.top <= collectionViewHeight/2.0 && frameV.top > 0){
                //蓝色
                _hourSelectedIndexPath = [collectionView indexPathForCell:cell];
                label.textColor = UIColor1(<#蓝#>);
            }else{
                label.textColor = [MyColor colorWithHexString:@"0xA2C4EE"];;

            }
        }
        
    }



}



@end
