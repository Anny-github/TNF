//
//  ClockTimeView.h
//  TNF
//
//  Created by dongliwei on 16/4/15.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClockTimeView : UIView

@property(nonatomic,copy)void(^selectedTime)(NSString *time,BOOL onOff);


-(void)showWithTime:(NSString*)time isOn:(BOOL)isOn;

@end
