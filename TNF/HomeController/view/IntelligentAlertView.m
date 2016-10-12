//
//  IntelligentAlertView.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "IntelligentAlertView.h"

@implementation IntelligentAlertView

-(void)awakeFromNib{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

+(void)show{
    
    IntelligentAlertView *view = [[NSBundle mainBundle]loadNibNamed:@"IntelligentAlertView" owner:nil options:nil].firstObject;
    view.nextBtn.selected = NO;
    [kWindow addSubview:view];
    
}

- (IBAction)nextTimeAlertBtn:(id)sender {
    
    self.nextBtn.selected = !self.nextBtn.selected;
    if (self.nextBtn.selected) {
        [UserDefaults setValue:@"1" forKey:IntelligentTestAlert];
    }else{
        [UserDefaults setValue:@"0" forKey:IntelligentTestAlert];

    }
    
}

- (IBAction)enterBtnClick:(id)sender {
    [self removeFromSuperview];
}

@end
