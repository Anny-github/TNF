//
//  BuyCourSucView.h
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^EnterOnLive)();

@interface BuyCourSucView : UIView

@property(nonatomic,copy)EnterOnLive enterOnLive;
-(BuyCourSucView*)initWithCourseName:(NSString*)name enterOnLive:(EnterOnLive)enterOnlive;

-(void)show;
-(void)hidden;

@end
