//
//  VoiceInfo.m
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoiceInfo.h"

@implementation VoiceInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       }];
}

@end
