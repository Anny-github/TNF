//
//  AppDelegate.m
//  TNF
//
//  Created by 刘翔 on 15/12/15.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "TFViewController.h"
#import "WXApi.h"
#import "LognViewController.h"
#import "WXLoginService.h"
#import "TFViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "RecoderView.h"
#import "MobClick.h"
#import "JPUSHService.h"


#import "MachineController.h"
#import "ClassController.h"
#import "TPOController.h"
#import "FuYuanViewController.h"
#import "TiShengViewController.h"
#import "MycourseViewController.h"
#import "WhizkidController.h"

//口语练习首页
#import "OralController.h"
#import "RootController.h"

#import "HomeViewController.h"


static NSString *appKey = @"7e6696e273cc33c43b24f2ac";
static NSString *channel = @"App Store";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<WXApiDelegate,UIScrollViewDelegate>
{

    UIPageControl *pageControl;
    UIScrollView *scrollView;
    UIAlertView *aleer;
//    UIImageView *imageView ;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    [self UMSetting];

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _imageView.hidden = YES;
    _imageView.tag = 2000;
    _imageView.image = [UIImage imageNamed:@"Default.png"];
    [self.window insertSubview:_imageView atIndex:0];
    _networkManager = [NetWorkManager sharedManager];
    _networkManager.delegate = self;
    
    [_networkManager startNetWorkeWatch];
    
#warning ----
    [[[SDWebImageManager sharedManager]imageCache] clearDiskOnCompletion:^{
        [[[SDWebImageManager sharedManager]imageCache] clearMemory];
    }];
//
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"-----currentVersion:%@",currentVersion);
    
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
    
   
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    //想微信注册
    [WXApi registerApp:WXAppID withDescription:@"demo 2.0"];
    
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLoginOut) name:Noti_LoginOut object:nil];
    //微信登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLoginOut) name:Noti_Dismiss object:nil];
    
    
    [WXDataService requestAFWithURL:@"http://test.warcello.cn/api/user?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIzLCJpc3MiOiJodHRwOlwvXC90ZXN0LndhcmNlbGxvLmNuXC9hcGlcL2xvZ2luIiwiaWF0IjoxNDY2NjY2Nzc3LCJleHAiOjE0NjY2NzAzNzcsIm5iZiI6MTQ2NjY2Njc3NywianRpIjoiOWQyN2RmMDJiYWVkNDVlNzY5NmRkM2U4OWM5ZDE5NzUifQ.ZexfPYadWbKB8AOafu-jN6yDweq0IkkHbtSj3fxgdnk" params:nil httpMethod:@"GET" finishBlock:^(id result) {
        
        NSLog(@"----result---%@",result);
        
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"------error---%@",error);
    }];
   
    [self wxLoginOut];
    
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        
        UIUserNotificationType type= UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    return YES;
}


#pragma mark ----友盟参数配置--
-(void)UMSetting{
    
    //UM统计
    [MobClick startWithAppkey:@"55c45a7de0f55abdef000e7e" reportPolicy:BATCH channelId:@"App Store"];
    
    //    // version标识
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //

#warning -- 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
    
    [UMSocialData setAppKey:@"55c45a7de0f55abdef000e7e"];
    
    
    [UMSocialWechatHandler setWXAppId:@"wx48a3a9ec633ccb96" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //微博
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4258008819" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //腾讯
    [UMSocialQQHandler setQQWithAppId:@"1105042847" appKey:@"CR2iSeOrlJH122qy" url:@"http://www.umeng.com/social"];

}



#pragma mark - NetWorkManagerDelegate
- (void) netWorkStatusWillChange:(NetworkStatus)status
{
   
    UIImageView *imageview = (UIImageView *)[self.window viewWithTag:2000];

    if(status == NotReachable)
    {
        _imageView.hidden = NO;
    } else {
        
        _imageView.hidden = YES;
        //        [self.window addSubview:imageview];
//        [self.window exchangeSubviewAtIndex:self.window.subviews.count - 1 withSubviewAtIndex:0];
        [self.window bringSubviewToFront:imageview];

    }
    
}
- (void)netWorkStatusWillDisconnection
{
    // @"网络断开";
  

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"您当前没有网络状态！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
//     UIImageView *imageview = (UIImageView *)[self.window viewWithTag:2000];
//    [self.window insertSubview:imageview atIndex:self.window.subviews.count - 1];
    _imageView.hidden = NO;
    [self.window bringSubviewToFront:_imageView];


    
    
}


- (void)wxLoginOut
{
    
    BaseNavigationController *baseNAV;
//    HomeViewController *home = [[HomeViewController alloc]init];
//    baseNAV = [[BaseNavigationController alloc]initWithRootViewController:home];
//    self.window.rootViewController = baseNAV;
//    return;
    
    if ([UserDefaults boolForKey:ISLogin] == NO) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults objectForKey:Userid];
        [MobClick profileSignInWithPUID:userId provider:@"WX"];
        
        //设置标识
        
        [JPUSHService setTags:[NSSet set]
                        alias:userId
             callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                       target:self];
        RootController *rootVC = [[RootController alloc]init];
        baseNAV = [[BaseNavigationController alloc]initWithRootViewController:rootVC];
//
//        OralController *OralVC = [[OralController alloc]init];
//        baseNAV = [[BaseNavigationController alloc] initWithRootViewController:OralVC];
//         TFViewController *TFVC = [[TFViewController alloc]init];
//         baseNAV = [[BaseNavigationController alloc] initWithRootViewController:TFVC];
       
    } else {
        
        
        LognViewController *loginVC = [[LognViewController alloc]init];
        baseNAV = [[BaseNavigationController alloc] initWithRootViewController:loginVC];

    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController =baseNAV;

}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,tags,alias];
    
    NSLog(@"TagsAlias回调:%@",callbackString);
}


#pragma mark -------- 微信代理 -------------------------------
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == YES) {
        return result;

    }
    return [WXApi handleOpenURL:url delegate:self];
        
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == YES) {
        return result;
        
    }
    return [WXApi handleOpenURL:url delegate:self];
    
}


#pragma mark - WXApiDelegate
-(void) onReq:(BaseReq*)req{
    NSLog(@"onReq");
}


-(void) onResp:(BaseResp*)resp{
    //    NSLog(@"onResp:code=%d",resp.errCode);
    //微信登陆
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *respond = (SendAuthResp*)resp;
        if (respond.errCode == 0) {
            [WXLoginService getWXLoginAccesstoken:respond.code];
            
        }
    }
    
//#warning --支付回调--
//    if ([resp isKindOfClass:[PayResp
//                             class]]) {
//        PayResp *response = (PayResp*)resp;
//        switch(response.errCode){
//            case WXSuccess:
//                //服务器端查询支付通知或查询API返回的结果再提示成功
//                NSLog(@"支付成功");
//                //发通知，在TNFPayManager中，询问服务器是否成功，成功则跳转到支付成功界面
//                break;
//            default:
//                NSLog(@"支付失败，retcode=%d",resp.errCode);
//                break;
//        }
//    }

    
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    

    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
        // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //baseViewController中处理推送
    [[NSNotificationCenter defaultCenter] postNotificationName:YOUPAINOTICE object:userInfo];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        UIViewController *vc = [self getCurrentVC];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        // modal展现方式的底层视图不同
        // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
        UIView *firstView = [keyWindow.subviews lastObject];
        UIViewController *vc = [firstView ViewController];
        NSString *op = [_objectDic objectForKey:@"op"];
        if ([op isEqualToString:@"getPracticeList1"]) {
            //机经预测列表
            if([vc isMemberOfClass:[MachineController class]]){
                
                return;
            }
            MachineController *machineVC = [[MachineController alloc] init];
            [vc.navigationController pushViewController:machineVC animated:YES];
            
            
        }else if ([op isEqualToString:@"getPracticeList2"]){
            //分类练习列表
            if([vc isMemberOfClass:[ClassController class]]){
                
                return;
            }
            ClassController *classVC = [[ClassController alloc] init];
            [vc.navigationController pushViewController:classVC animated:YES];
            
        }else if ([op isEqualToString:@"getPracticeList3"]){
            //TPO真题列表
            if([vc isMemberOfClass:[TPOController class]]){
                
                return;
            }
            TPOController *tpoVC = [[TPOController alloc] init];
            [vc.navigationController pushViewController:tpoVC animated:YES];
            
        }else if ([op isEqualToString:@"getZhiboList"]){
            //直播
            if([vc isMemberOfClass:[TiShengViewController class]]){
                
                return;
            }
            TiShengViewController *tisheVC = [[TiShengViewController alloc] init];
            [vc.navigationController pushViewController:tisheVC animated:YES];
            
        }else if ([op isEqualToString:@"myCourseList"]){
            //课程
            if([vc isMemberOfClass:[MycourseViewController class]]){
                
                return;
            }
            MycourseViewController *myVC = [[MycourseViewController alloc] init];
            [vc.navigationController pushViewController:myVC animated:YES];
            
        }else if ([op isEqualToString:@"getMyAmount"]){
            //积分
            if([vc isMemberOfClass:[FuYuanViewController class]]){
                
                return;
            }
            FuYuanViewController *fuyuanVC = [[FuYuanViewController alloc] init];
            [vc.navigationController pushViewController:fuyuanVC animated:YES];
            
        }else if([op isEqualToString:@"mp3Details"]){
            
            if([vc isMemberOfClass:[WhizkidController class]]){
//                [[NSNotificationCenter defaultCenter] postNotificationName:Noti_tiaozhuan object:[_objectDic objectForKey:@"id"]];
//                 return;
            }
            
            WhizkidController *whVC = [[WhizkidController alloc] init];
            whVC.ID = [_objectDic objectForKey:@"id"];
            [vc.navigationController pushViewController:whVC animated:YES];
        }else{
        
            FuYuanViewController *fuyuanVC = [[FuYuanViewController alloc] init];
            [vc.navigationController pushViewController:fuyuanVC animated:YES];
            

        
        }
    }

}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    UIView *frontView = [[window subviews] lastObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark---获取当前VC
- (UIViewController*)currentViewController
{
    UIViewController *vc = self.window.rootViewController;
    if ([vc isKindOfClass:[BaseNavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)vc;
        NSInteger count = nav.viewControllers.count;
        if (count) {
            UIViewController *vc = nav.viewControllers[count-1];
            return vc;
        }
        return nil;
    }
    else
    {
        return nil;
    }
    
}

+ (UIViewController *)currentViewController
{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    // modal展现方式的底层视图不同
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = [secondView ViewController];
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSLog(@"notificationUserInfo----%@",notification.userInfo);

    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
