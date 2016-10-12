//
//  DayTimeAlertCell.h
//  TNF
//
//  Created by dongliwei on 16/4/15.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTimeAlertCell : UITableViewCell

@property(nonatomic,copy)void(^timeisOn)(BOOL isOn);

@property(nonatomic,strong)NSDictionary *timeDic;

@end
