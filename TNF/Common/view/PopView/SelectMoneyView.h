//
//  SelectMoneyView.h
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectMoneyView : UIView

@property(nonatomic,copy)void(^selectedMoney)();
+(instancetype)showWithMoneyData:(NSDictionary*)dic;

@end
