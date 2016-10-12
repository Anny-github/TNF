//
//  DayTimeAlertCell.m
//  TNF
//
//  Created by dongliwei on 16/4/15.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "DayTimeAlertCell.h"

@interface DayTimeAlertCell ()
{
    UILabel *_timeLabel;
    UISwitch *_switchV;
}
@end
@implementation DayTimeAlertCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initViews];
    }
    
    return self;
    
}

#pragma mark -- 创建子视图--
-(void)initViews{
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*ratioWidth, self.contentView.centerY - 10, 100, 20)];
    _timeLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.contentView addSubview:_timeLabel];
    
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom, 50, 20)];
    dayLabel.text = @"每日";
    dayLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:dayLabel];
    
    _switchV = [[UISwitch alloc]initWithFrame:CGRectMake(self.contentView.width - 10*ratioWidth - 50, self.contentView.height/2.0-31/2.0, 0, 0)];
    _switchV.tintColor = UIColor2(<#灰色背景#>);
    _switchV.onTintColor = UIColor1(<#蓝#>);
    [_switchV addTarget:self action:@selector(timeOfOffEvent:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_switchV];
    
}


-(void)setTimeDic:(NSDictionary *)timeDic{
    _timeDic = timeDic;
    _timeLabel.text = timeDic[@"datetime"];
    [_switchV setOn:[timeDic[@"is_open"] intValue] == 0 ? NO:YES];
}

-(void)layoutSubviews{
    _switchV.centerY = self.contentView.height/2.0;
    _switchV.centerX = self.contentView.width - 10*ratioWidth - 25;
    [super layoutSubviews];
}

#pragma makr --开关--
-(void)timeOfOffEvent:(UISwitch*)switchV{
    
    self.timeisOn(switchV.isOn); //刷新cell
    
    //已注册的所有通知里存在该时间
    NSArray *notification = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification *nofi in notification) {
        
        if ([nofi.userInfo[@"time"] isEqualToString:self.timeDic[@"datetime"]]) {
            //此时间开启过
            if (switchV.isOn) {
                    return;
            }else{ //关闭此推送
                [[UIApplication sharedApplication]cancelLocalNotification:nofi];
                return;
                
            }
        }
        
    }
    
    //开启此时间的推送
    if (switchV.isOn) {
        UILocalNotification *newNofi=[[UILocalNotification alloc] init];
        if (newNofi != nil) {
            newNofi.fireDate= [TNFPublicTool fireDate:self.timeDic[@"datetime"]];
            newNofi.timeZone=[NSTimeZone defaultTimeZone];
            newNofi.alertBody=@"口语医生提醒您,练习时间到了！";
            newNofi.soundName = UILocalNotificationDefaultSoundName;
            newNofi.repeatInterval = NSCalendarUnitDay;
            newNofi.userInfo = @{@"time":self.timeDic[@"datetime"]};
            [[UIApplication sharedApplication] scheduleLocalNotification:newNofi];
            
        }

    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
