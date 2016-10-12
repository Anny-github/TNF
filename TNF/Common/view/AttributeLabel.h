//
//  AttributeLabel.h
//  TNF
//
//  Created by wss on 16/5/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttributeLabel : UIView
@property(nonatomic,copy)NSString *leftTitle;
@property(nonatomic,copy)NSString *rightTitle;



-(AttributeLabel*)initWithFrame:(CGRect)frame leftText:(NSString*)leftTitle rightText:(NSString*)rightTitle;


@end
