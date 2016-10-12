//
//  TNFPublicTool.h
//  TNF
//
//  Created by dongliwei on 16/4/14.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNFPublicTool : NSObject

/**
 *  根据12:35 计算今天12:35 的date
 */
+(NSDate*)fireDate:(NSString*)time;

/**
 * 手机号检查
 **/
+(BOOL)checkPhone:(NSString*)phone;


/**
    MBProgressHUD
 
 */
+ (void)showHUDWithView:(UIView *)curView;
+ (void)hideHUDWithView:(UIView *)curView;
+ (void)HUDWithString:(NSString *)strText;


+ (UIViewController *)getCurrentVC;
@end
