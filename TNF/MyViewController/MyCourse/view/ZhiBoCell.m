//
//  ZhiBoCell.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "ZhiBoCell.h"

@interface ZhiBoCell ()
{
    
    IBOutlet UIImageView *_headImg;
    IBOutlet UILabel *_title;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_time;
}
@end

@implementation ZhiBoCell

- (void)awakeFromNib {
    self.backgroundColor = UIColor2(<#灰色背景#>);
    self.contentView.backgroundColor = UIColor2(<#灰色背景#>);
    _headImg.layer.cornerRadius = _headImg.width/2.0;
    _headImg.layer.masksToBounds = YES;
}

- (IBAction)commentBtnClick:(id)sender {
    self.commentBtnClick();
}
- (IBAction)lectureBtnClick:(id)sender {
    self.lectureBtnClick();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
