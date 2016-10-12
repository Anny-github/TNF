//
//  SubjectModel.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       }];
}

-(NSMutableArray *)voiceArr{
    NSArray *voiceArray = self.mp3_list_my;

    NSArray *voiceArr = self.mp3_list;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:voiceArray];
    [arr addObjectsFromArray:voiceArr];
    return arr;
}

@end
