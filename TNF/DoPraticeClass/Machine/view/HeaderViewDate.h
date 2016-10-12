//
//  HeaderViewDate.h
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewDate : UIView
{
    UILabel *label1;
    UILabel *label2;
    
}
@property(nonatomic,copy)NSString *text1;
@property(nonatomic,copy)NSString *text2;
@property(nonatomic,copy)NSString *dateStr;

@end
