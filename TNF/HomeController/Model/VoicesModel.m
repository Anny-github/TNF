//
//  VoicesModel.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoicesModel.h"

@implementation VoicesModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       }];
}

@end
