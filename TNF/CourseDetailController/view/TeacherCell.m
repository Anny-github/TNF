//
//  TeachCell.m
//  TNF
//
//  Created by wss on 16/4/27.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TeacherCell.h"


@interface TeacherCell ()
{
    
    IBOutlet UIImageView *_headImg;
    
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_levelnme;
    
    IBOutlet UIView *_startView;
    IBOutlet UILabel *_fen;
    
    IBOutlet UILabel *_content;
}
@end

@implementation TeacherCell

- (void)awakeFromNib {
    
    _headImg.layer.cornerRadius = _headImg.width/2.0;
    _headImg.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
