//
//  SubjectFileModel.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SubjectFileModel.h"

@implementation SubjectFileModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       }];
}
@end
