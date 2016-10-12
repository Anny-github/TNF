//
//  VoiceCell.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoiceCell.h"
#import "LoadImage.h"
#import "UIImage+Resize.h"
#import "NERWebImageManager.h"

@interface VoiceCell ()
{
    
    IBOutlet UIView *bgView;
    
    IBOutlet UIButton *rightimgV;
    IBOutlet UIImageView *_leftIconView;
}

@end
@implementation VoiceCell

- (void)awakeFromNib {

       
}

-(void)setModel:(VoicesModel *)model{
    _model = model;
    if (model.isComment == 0) {
        rightimgV.hidden = YES;
    }else{
        rightimgV.hidden = NO;
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [LoadImage loadAnnotationImageWithURL:self.model.headimgurl imageView:headImgV finish:^{

    }];
    
    
}

@end
