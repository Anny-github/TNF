//
//  CorrectPopView.h
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RequestSuccess)();
@interface CorrectPopView : UIView
@property(nonatomic,copy)RequestSuccess requestSuccess;

-(CorrectPopView*)initWithData:(NSDictionary*)dataDic requestCorrectSuccess:(RequestSuccess)requestSuccess;

-(void)show;
-(void)hide;

@end
