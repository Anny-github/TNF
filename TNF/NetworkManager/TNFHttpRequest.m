//
//  TNFRequest.m
//  TNF
//
//  Created by dongliwei on 16/4/18.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TNFHttpRequest.h"

@implementation TNFHttpRequest

/**
 *   登录
 */
+(void)loginWithParam:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle
{
    [WXDataService requestAFWithURL:Url_Login params:param httpMethod:@"POST" finishBlock:^(id result) {
        
        
    } errorBlock:^(NSError *error) {
        
        
    }];
}


/**
 *   获取个人信息
 */
+(void)getUserInfo:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle{
    
    [WXDataService requestAFWithURL:Url_getUpdateSetting params:param httpMethod:@"POST" finishBlock:^(id result) {
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [TNFPublicTool HUDWithString:result[@"msg"]];
            return;
            
        }

        
        PersonaModel *person = [[PersonaModel alloc]initWithDictionary:result[@"result"] error:nil];
        completeHandle(person);
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}


/**
 *  获取题目详情
 */
+(void)getSubjectDetai:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle{
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:param httpMethod:@"POST" finishBlock:^(id result) {
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [TNFPublicTool HUDWithString:result[@"msg"]];
            
            completeHandle(nil);
            return ;
        }
        
        NSDictionary *dic = result[@"result"];
        SubjectModel *subjectM = [[SubjectModel alloc]initWithDictionary:dic error:nil];
        completeHandle(subjectM);
        
    } errorBlock:^(NSError *error) {
        completeHandle(nil);

    }];
}


/**
 *  获取声音详情
 */
+(void)getVoiceDetail:(NSDictionary*)param completeHandle:(CompleteHandle)completeHandle{
    
    [WXDataService requestAFWithURL:Url_mp3Details params:param httpMethod:@"POST" finishBlock:^(id result) {
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [TNFPublicTool HUDWithString:result[@"msg"]];
            
            completeHandle(nil);
            return ;
        }
        
        NSDictionary *dic = result[@"result"];
        VoiceDetailModle *voiceDetail = [[VoiceDetailModle alloc]initWithDictionary:dic error:nil];
        completeHandle(voiceDetail);
        
    
    } errorBlock:^(NSError *error) {
        completeHandle(nil);
    }];
    
}

@end
