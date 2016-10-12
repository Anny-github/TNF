//
//  RewardCell.m
//  TNF
//
//  Created by wss on 16/5/11.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "RewardCell.h"

@interface RewardCell ()
{
    IBOutlet UIButton *moneyBtn;
    IBOutlet UILabel *titleL;
    
    IBOutlet UILabel *subTitle;
    IBOutlet NSLayoutConstraint *titleLCenterY; //若只有title，则titleLCenterY = 0
}
@end
@implementation RewardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
