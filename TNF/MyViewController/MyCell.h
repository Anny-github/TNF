//
//  MyCell.h
//  TNF
//
//  Created by wss on 16/5/10.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;

@property (strong, nonatomic) IBOutlet UILabel *accessoryTitle;

@end
