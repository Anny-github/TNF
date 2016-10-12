//
//  MyCell.m
//  TNF
//
//  Created by wss on 16/5/10.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyCell.h"


@implementation MyCell

- (void)awakeFromNib {

    _titleLabel.textColor = UIColorSubTitle;
    _accessoryTitle.textColor = UIColorSubTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
