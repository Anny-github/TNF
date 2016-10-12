//
//  UIView+RadioView.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "UIView+RadioView.h"

@implementation UIView (RadioView)

-(void)radiu:(CGFloat)radiu borderWidth:(CGFloat)width borderColor:(UIColor*)color{
    self.layer.cornerRadius = radiu;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    
    
}
@end
