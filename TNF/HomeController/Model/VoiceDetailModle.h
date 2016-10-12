//
//  VoiceDetailModle.h
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//声音详情

/**
 mp4Url 评分标准视频
 info 好声音详情
     type类型 1托福 2雅思
     is_self是否自己录音 1是 0否
     time时长
     mp3好声音地址
     nickname用户昵称
     headimgurl用户头像
     teacher_member_id老师ID
     teacher_nickname老师昵称
     teacher_headimgurl老师头像
     fen1分数一
     fen2分数二
     fen3分数三
     fen4分数四(当type=2的时候才有)
     fen综合分数
 subject_info题目详情
     title标题
     question问题部分
     reading阅读部分
     mp3语音部分
     type类型 1托福 2雅思
     level难度
mp3_list老师点评列表
     mp3点评地址
com_list老师点评建议
     id建议ID
     title标题
comment_list评论列表
     is_self是否自己评论 1是 0否
     group用户组 1学生 2老师
     type类型1文本 2语音
     mp3评论地址
     content评论内容
     nickname昵称
     headimgurl头像

*/

#import <JSONModel/JSONModel.h>

@protocol CommentModel;
@interface VoiceDetailModle : JSONModel

@property(nonatomic,copy)NSString *mp4Url;
@property(nonatomic,strong)VoiceInfo * info;
@property(nonatomic,strong)SubjectInfoModel *subject_info;
@property(nonatomic,strong)NSArray *mp3_list;
@property(nonatomic,strong)NSArray *com_list;
@property(nonatomic,strong)NSArray <CommentModel> *comment_list;






@end








