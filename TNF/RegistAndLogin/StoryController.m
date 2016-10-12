//
//  StoryController.m
//  TNF
//
//  Created by wss on 16/5/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "StoryController.h"
#import "YYText.h"

@interface StoryController ()
{
    
    UILabel *titleLabel;
}
@property(nonatomic,strong)YYLabel *label;
@end

@implementation StoryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initViews];
}


-(void)initViews{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*ratioWidth, 37*ratioHeight, 50, 50)];
    [backBtn setImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*ratioHeight, self.view.width, 20)];
    titleLabel.centerY = backBtn.centerY;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // UIImage attachment

    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:14];
    {
        
    
        UIImage *image = [UIImage imageNamed:@"blueBg_short"];
        image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeTopLeft attachmentSize:CGSizeMake(50, 80) alignToFont:font alignment:YYTextVerticalAlignmentTop];
        [text appendAttributedString:attachText];

        NSString *title = @"This is UIImage attachment This is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachmentThis is UIImage attachment:";
       //
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        
    }

//    YYTextAttachment
    text.yy_font = font;
    
    _label = [YYLabel new];
    _label.numberOfLines = 0;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _label.size = CGSizeMake(320,300);
    _label.center = CGPointMake(self.view.width / 2, self.view.height / 2);
    _label.attributedText = text;
    [self.view addSubview:_label];
    
}



-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
