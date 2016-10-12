//
//  LDZMoviePlayerController.h
//  LDZMoviewPlayer_Xib
//
//  Created by rongxun02 on 15/11/24.
//  Copyright © 2015年 DongZe. All rights reserved.

/**
 *  视频播放界面  xib做好了控制视图横竖屏的适配topView和backButton，代码只需做playerLayer的横竖屏适配
 */


#import <UIKit/UIKit.h>

@interface LDZMoviePlayerController : UIViewController

@property (nonatomic, strong) NSURL *movieURL;

@end
