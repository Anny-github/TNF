//
//  TNFPayManager.m
//  TNF
//
//  Created by dongliwei on 16/4/13.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TNFPayManager.h"

@implementation TNFPayManager

static  TNFPayManager *instance = nil;
static dispatch_once_t onceToken = 0;

+(instancetype)sharedMgr
{
    dispatch_once(&onceToken, ^{
        instance = [[TNFPayManager alloc]init];
    });
    return instance;
    
}


-(void)payOrder:(NSDictionary*)param payType:(TNFPayType)payType completeHandle:(TNFPayCompleteHandle)completeHandle
{
    
    [WXDataService requestAFWithURL:@"" params:param httpMethod:@"POST" finishBlock:^(id result) {
        
        if (payType == TNFPayTypeWXIN) {
            
            [self  wxinPay:result completeHandle:completeHandle];
        }else if(payType == TNFPayTypeAlipay){
            [self aliPay:result comleteHandle:completeHandle];
            
        }
    } errorBlock:^(NSError *error) {
            completeHandle(nil);

    }];
    
    
}

#pragma mark --微信支付--
-(void)wxinPay:(NSDictionary*)param completeHandle:(TNFPayCompleteHandle)completeHandle{
 
    
    [WXApi sendReq:nil];
    
}

#pragma mark --支付宝支付--
-(void)aliPay:(NSDictionary*)param comleteHandle:(TNFPayCompleteHandle)completeHandle{
    
}





@end
