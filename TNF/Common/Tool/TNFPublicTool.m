//
//  TNFPublicTool.m
//  TNF
//
//  Created by dongliwei on 16/4/14.
//  Copyright © 2016年 刘翔. All rights reserved.
//



#pragma mark - NEARHUD

@interface NERHUD : MBProgressHUD

@end



@implementation NERHUD

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end


#import "TNFPublicTool.h"

@implementation TNFPublicTool


#pragma mark --根据12:35 计算今天12:35 的date
+(NSDate*)fireDate:(NSString*)time{
    
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; //今日
    NSDateComponents *comp1  = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    
    int year = comp1.year;
    NSString *month = (comp1.month / 10) > 0? [NSString stringWithFormat:@"%d",comp1.month] : [NSString stringWithFormat:@"0%d",comp1.month];
    NSString *day = (comp1.day / 10) > 0 ? [NSString stringWithFormat:@"%d",comp1.day] : [NSString stringWithFormat:@"0%d",comp1.day];
    
    NSString *dateStr = [NSString stringWithFormat:@"%d-%@-%@ %@",year,month,day,time];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeZone = [NSTimeZone localTimeZone];
    [format setDateFormat:@"YYYY-MM-DD HH:mm"];
    return [format dateFromString:dateStr];
    
}


+ (BOOL)checkPhone:(NSString*)phone {
    if ([phone length] == 0) {
        [TNFPublicTool HUDWithString:@"手机号码不能为空"];
        return NO;
    }
    else {
        NSString *regex = @"^(1[3|4|5|7|8|9][0-9]\\d{8})$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phone];
        if (!isMatch) {
            [TNFPublicTool HUDWithString:@"请正确填写手机号"];
            return NO;
        }
    }
    return YES;
}

/**
 MBProgressHUD
 
 */
+ (void)showHUDWithView:(UIView *)curView {
    [NERHUD showHUDAddedTo:curView animated:YES];
}

+ (void)hideHUDWithView:(UIView *)curView {
    [NERHUD hideHUDForView:curView animated:YES];
}

+ (void)HUDWithString:(NSString *)strText {
    MBProgressHUD *HUD = [NERHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    HUD.userInteractionEnabled = NO;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabelText = strText;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.color = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [HUD hide:YES afterDelay:1.f];
}

+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
