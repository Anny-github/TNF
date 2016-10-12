//
//  UIView+ViewController.h
//  zsmWeiboDemo
//
//  Created by 朱思明 on 13-5-23.
//  Copyright (c) 2013年 朱思明. All rights reserved.
/**
 *  返回当前view的viewcontroller，通过nextResponder
 */

#import <UIKit/UIKit.h>

@interface UIView (ViewController)
- (UIViewController *)ViewController;
@end
