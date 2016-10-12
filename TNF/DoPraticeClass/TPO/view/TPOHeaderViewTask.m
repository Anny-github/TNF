//
//  TPOHeaderViewTask.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TPOHeaderViewTask.h"


@interface TPOHeaderViewTask ()
{
    UILabel *titleL;
    UIButton *btn;
}
@end
@implementation TPOHeaderViewTask

-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];

    }
    return self;
}


-(void)initViews{
    
   titleL = [[UILabel alloc]initWithFrame:CGRectMake(10*ratioWidth, 0, 120, self.height)];
    titleL.text = _title;
    titleL.textColor = UIColor1(<#蓝#>);
    [self addSubview:titleL];

    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-10*ratioWidth - 44*ratioWidth, 0, 44*ratioWidth, self.height)];
    btn.selected = NO;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    titleL.text = title;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    [btn setImage:image forState:UIControlStateNormal];
}

-(void)setSelectedImg:(UIImage *)selectedImg{
    _selectedImg = selectedImg;
    [btn setImage:selectedImg forState:UIControlStateSelected];
}

-(void)btnClick:(UIButton*)button{
    
    button.selected = !button.selected;
    self.btnSelected(button.selected);
}


@end
