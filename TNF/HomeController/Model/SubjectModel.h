//
//  SubjectModel.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//
/*cur当前第几个
 count总共几个
 pre上一题ID(没有时为0)
 next下一题ID(没有时为0)
 amount福币数
 lid关联ID
 type类型
 long录音时长
 info题目详情
 id题目ID
 title标题
 mp3听力部分
 question问题部分
 reading阅读部分
 */


#import <JSONModel/JSONModel.h>
#import "SubjectInfoModel.h"

@protocol VoicesModel;
@protocol SubjectFileModel;

@interface SubjectModel : JSONModel

@property(nonatomic,copy)NSString *cur;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *pre;
@property(nonatomic,copy)NSString *next;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *lid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString <Optional>*longs;
@property(nonatomic,copy)NSString <Optional>*content;  //解题思路

@property(nonatomic,retain)SubjectInfoModel *info;
@property(nonatomic,strong)NSMutableArray<VoicesModel,Optional> *mp3_list; //其他优等生
@property(nonatomic,strong)NSMutableArray <VoicesModel,Optional> *mp3_list_my;
@property(nonatomic,retain)NSMutableArray <SubjectFileModel,Optional>*files; //相关素材

@property(nonatomic,strong)NSMutableArray <Optional> *voiceArr;

@end
