//
//  LXSgement.m
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXSgement.h"

@implementation LXSgement

- (id)initWithFrame:(CGRect)frame
              titles:(NSArray *)titles
        normalColor:(UIColor *)normalColor
      selectedColor:(UIColor *)selectedColor
        bottomColor:(UIColor *)bottomColor
      divisionColor:(UIColor *)divisionColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _seltedIndex = 0;
        bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        //线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.height-1, self.frame.size.width, 1)];
        line.backgroundColor = UIColor2(<#灰色背景#>);
        
        [self addSubview:line];
        
        [self addSubview:bgView];
        for (int i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(self.width / titles.count * i, 0, self.width / titles.count, self.height);
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:normalColor forState:UIControlStateNormal];
            [button setTitleColor:selectedColor forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15 *ratioHeight];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
            if (i == 0) {
                button.selected = YES;
            }

        }
        
        for (int i = 0; i < titles.count - 1; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / titles.count * (i +1), 0, 1, self.height)];
            imageView.backgroundColor = divisionColor;
            [self addSubview:imageView];
        }
        
        seltedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width / titles.count, 1)];
        seltedImageView.backgroundColor = bottomColor;
        [self addSubview:seltedImageView];
        
        

    }
    return self;
}

-(void)setTitlesArray:(NSArray *)titlesArray
{

    _titlesArray = titlesArray;
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:(100 + i)];
        [button setTitle:_titlesArray[i] forState:UIControlStateNormal];
    }


}

- (void)buttonAction:(UIButton *)sender
{
    if (_seltedIndex+100 == sender.tag) {
        return;
    }
    
    UIButton *button = [bgView viewWithTag:_seltedIndex + 100];
    button.selected = NO;

    [UIView animateWithDuration:0.3 animations:^{
//        sender.selected = YES;
        seltedImageView.left = sender.left;
    }];
    
    _seltedIndex = sender.tag - 100;

    [self.delegate clickindex:sender.tag - 100];


}

-(void)selectedIndex:(int)index{
    
    UIButton *button = [bgView viewWithTag:_seltedIndex + 100];
    button.selected = NO;
    
    UIButton *selctBtn = [bgView viewWithTag:index + 100];

    seltedImageView.left = selctBtn.left;
    _seltedIndex = index;
    selctBtn.selected = YES;
}

@end





































