//
//  MachineCell.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MachineCell.h"

@interface MachineCell ()
{
    IBOutlet UIView *bgView;
    IBOutlet UIImageView *_imgView;
    
    IBOutlet UIImageView *imgICon;
    
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_subTitle;
    IBOutlet UILabel *countLabel;
    
    IBOutlet NSLayoutConstraint *imgLeft;
    
    IBOutlet NSLayoutConstraint *imgRight;
}
@end

@implementation MachineCell

- (void)awakeFromNib {
    self.backgroundColor = [MyColor colorWithHexString:@"f3f3f3"];
    self.contentView.backgroundColor = [MyColor colorWithHexString:@"f3f3f3"];
    
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3.0;
    bgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 3.0;
    _imgView.layer.masksToBounds = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.type == 0) { //左边
        imgLeft.constant = 10;
        imgRight.constant = 2.5;
    }else{
        imgLeft.constant = 5.0;
        imgRight.constant = 10;
 
    }
}

@end
