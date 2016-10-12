//
//  CommentCell.m
//  TNF
//
//  Created by wss on 16/4/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "CommentCell.h"


@interface CommentCell ()
{
    IBOutlet UILabel *_content;
    
    IBOutlet UILabel *_name;
    IBOutlet UIView *_startView;
    IBOutlet UILabel *_time;
    IBOutlet UILabel *_shang;
    
    IBOutlet UILabel *_addContent;
}
@end

@implementation CommentCell

- (void)awakeFromNib {

    self.backgroundColor = UIColor2(<#灰色背景#>);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
