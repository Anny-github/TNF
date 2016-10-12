//
//  TNFLogin.m
//  TNF
//
//  Created by wss on 16/4/25.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TNFLogin.h"
#import "UMSocial.h"
#import "WXApi.h"


@implementation TNFLogin

static TNFLogin *instance = nil;
static dispatch_once_t onceToken = 0;
+(TNFLogin*)shared{
    
    dispatch_once(&onceToken, ^{
        instance = [[TNFLogin alloc]init];
    });
    return instance;
    
}
-(void)loginWithType:(TNFLoginType)loginType{
    switch (loginType) {
        case TNFLoginTypeQQ:
             [instance loginWithQQ];
            break;
        case TNFLoginTypeWEIXIN:
            [instance loginWithWEIXIN];

            break;
        case TNFLoginTypeWEIBO:
           [instance loginWithWEIBO];
            break;
            
        default:
            break;
    }
}

-(void)loginWithQQ{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(nil,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}


-(void)loginWithWEIXIN{
    
    NSLog(@"微信登录");
    
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
    
}

-(void)loginWithWEIBO{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(nil,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];

            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
}

@end
