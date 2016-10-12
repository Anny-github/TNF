//
//  NotificationCell.m
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "NotificationCell.h"

@interface NotificationCell ()
{
    
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_point;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UILabel *_contentLabel;
}
@end

@implementation NotificationCell

- (void)awakeFromNib {

    _point.layer.cornerRadius = _point.width/2.0;
    _point.layer.masksToBounds = YES;
    _point.text = @"3";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
