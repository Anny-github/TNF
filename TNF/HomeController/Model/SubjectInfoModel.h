//
//  SubjectInfoModel.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

/* SubjectInfoModel 题目详情
 id题目ID
 title标题
 mp3听力部分
 question问题部分
 reading阅读部分
 level 难度
 */

#import <JSONModel/JSONModel.h>

@interface SubjectInfoModel : JSONModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *mp3;
@property(nonatomic,copy)NSString *question;
@property(nonatomic,copy)NSString *reading;
@property(nonatomic,copy)NSString <Optional>*level;


@end
