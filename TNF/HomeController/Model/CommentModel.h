//
//  CommentModel.h
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
/* 评论model
is_self是否自己评论 1是 0否
group用户组 1学生 2老师
type类型1文本 2语音
mp3评论地址
content评论内容
nickname昵称
headimgurl头像
 */

#import <JSONModel/JSONModel.h>

@interface CommentModel : JSONModel

@property(nonatomic,copy)NSString *is_self;
@property(nonatomic,copy)NSString *group;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *mp3;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *headimgurl;


@end
