//
//  TNFRequest.h
//  TNF
//
//  Created by dongliwei on 16/4/18.
//  Copyright © 2016年 刘翔. All rights reserved.

/**
 *  所有页面的网络请求
 */

#import <Foundation/Foundation.h>


@interface TNFHttpRequest : NSObject

/**
 *   登录
 */
+(void)loginWithParam:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle;

/**
 *   获取个人信息
 */
+(void)getUserInfo:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle;


/**
 *  获取题目详情
 */
+(void)getSubjectDetai:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle;
/**
 *  获取声音详情
 */
+(void)getVoiceDetail:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle;


@end
