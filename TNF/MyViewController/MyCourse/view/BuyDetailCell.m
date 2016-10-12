//
//  ReplayDetailCell.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BuyDetailCell.h"

@interface BuyDetailCell ()
{
    
    IBOutlet UIImageView *_headImg;
    IBOutlet UILabel *_title;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_time;
    
    IBOutlet UIView *_startView;
    IBOutlet UILabel *fen;
    
    
}
@end


@implementation BuyDetailCell

- (void)awakeFromNib {
    self.backgroundColor = UIColor2(<#灰色背景#>);
    self.contentView.backgroundColor = UIColor2(<#灰色背景#>);
    _headImg.layer.cornerRadius = _headImg.width/2.0;
    _headImg.layer.masksToBounds = YES;
}


- (IBAction)commentBtnClick:(UIButton *)sender {
    self.commentBtnClick();
}
- (IBAction)lectureBtnClick:(UIButton *)sender {
    self.lectureBtnClick();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
