//
//  VoicesModel.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
/**
 *  优等声
 id优等声ID
 time录音时长
 member_id用户ID
 nickname用户昵称
 headimgurl用户头像
 fen星星数
 addtime上传时间
 isComment是否已点评 1已点评 0未点评
 isCommentCN是否已点评文字
 */

#import <JSONModel/JSONModel.h>

@interface VoicesModel : JSONModel


@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *addtime;
@property(nonatomic,copy)NSString *member_id;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *headimgurl;
@property(nonatomic,copy)NSString *fen;
@property(nonatomic,copy)NSString *isComment;
@property(nonatomic,copy)NSString *isCommentCN;



@end
