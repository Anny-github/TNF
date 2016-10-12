//
//  ReplayCell.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyBuyCourseCell.h"
#import "PayController.h"
#import "BuyCourSucView.h"

@interface MyBuyCourseCell ()
{
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *firstName;
    __weak IBOutlet UILabel *secondName;
    
    __weak IBOutlet UILabel *thirdName;
    __weak IBOutlet UIImageView *firstImg;
    
    __weak IBOutlet UIImageView *secondImg;
    
    __weak IBOutlet UIImageView *thirdImg;
    
    IBOutlet UIButton *beginOrEndImg;
    IBOutlet UIButton *_buyButton;
    IBOutlet UILabel *_moneyL;
    
    
    IBOutlet UILabel *_timeLabel;
}
@end

@implementation MyBuyCourseCell

- (void)awakeFromNib {
    // Initialization code

    firstImg.layer.cornerRadius = firstImg.width/2.0;
    firstImg.layer.masksToBounds = YES;
    secondImg.layer.cornerRadius = firstImg.width/2.0;
    secondImg.layer.masksToBounds = YES;
    thirdImg.layer.cornerRadius = firstImg.width/2.0;
    thirdImg.layer.masksToBounds = YES;
    titleLabel.numberOfLines = -1;
    [titleLabel sizeToFit];
}

- (IBAction)buyCourseBtnClick:(id)sender {
    
    PayController *payVC = [[PayController alloc]init];
    
    [[self ViewController].navigationController pushViewController:payVC animated:YES];
    BuyCourSucView *view = [[BuyCourSucView alloc]initWithCourseName:@"热点预测5" enterOnLive:^{
        
    }];
    [view show];
    
}


@end
