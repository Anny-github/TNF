//
//  BottomView.h
//  TNF
//
//  Created by wss on 16/4/25.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView


@property(nonatomic,strong)VoicesModel *voice;
@property(nonatomic,copy)NSString *playingUrl;
@property(nonatomic,strong)AVPlayer *player;
-(void)pausePlay;
-(void)beginPlay;
-(void)keepPlay;
-(void)stopPlay;
@end
