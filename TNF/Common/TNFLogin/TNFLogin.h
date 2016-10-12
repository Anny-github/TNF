//
//  TNFLogin.h
//  TNF
//
//  Created by wss on 16/4/25.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TNFLoginTypeQQ,
    TNFLoginTypeWEIXIN,
    TNFLoginTypeWEIBO
    
}TNFLoginType;

@interface TNFLogin : NSObject


+(TNFLogin*)shared;

-(void)loginWithType:(TNFLoginType)loginType;

@end
