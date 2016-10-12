//
//  VoiceCollectCell.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoiceCollectCell.h"

@interface VoiceCollectCell ()
{
    
    IBOutlet UILabel *_titleLabel;
    
    IBOutlet UIImageView *_headImg;
}
@end


@implementation VoiceCollectCell

- (void)awakeFromNib {
    // Initialization code
    
    [LoadImage loadAnnotationImageWithURL:[UserDefaults valueForKey:IcanUrl] imageView:_headImg finish:^{
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
