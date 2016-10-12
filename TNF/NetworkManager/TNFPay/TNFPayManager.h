//
//  TNFPayManager.h
//  TNF
//
//  Created by dongliwei on 16/4/13.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef enum : NSUInteger {
    TNFPayTypeWXIN,
    TNFPayTypeAlipay,
    
} TNFPayType;

typedef void(^TNFPayCompleteHandle)(NSString *orderIdStr);

@interface TNFPayManager : NSObject

+(instancetype)sharedMgr;

-(void)payOrder:(NSDictionary*)param payType:(TNFPayType)payType completeHandle:(TNFPayCompleteHandle)completeHandle;


@end
