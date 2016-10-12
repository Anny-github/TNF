//
//  ReplayDetailCell.h
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyDetailCell : UITableViewCell
@property(nonatomic,copy)void(^commentBtnClick)(); //评论点击
@property(nonatomic,copy)void(^lectureBtnClick)(); //讲义点击

@end
