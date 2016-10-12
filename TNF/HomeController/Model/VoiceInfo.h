//
//  VoiceInfo.h
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

/*

 addtime = 1451368646;
 backgroupimg = "http://wx.qlogo.cn/mmopen/OTia7c2CX3CclGXg35HuNAcELh3dElGF6votrZMgQBH9ticIiaaRGNhgmJ3iagaOAfgZNeZlHpT2OaWGG71xfvxM1ydDZ4wIOeuK/0";
 fen = "2.3";
 fen1 = 2;
 fen2 = 3;
 fen3 = 2;
 fen4 = 0;
 headimgurl = "http://wx.qlogo.cn/mmopen/OTia7c2CX3CclGXg35HuNAcELh3dElGF6votrZMgQBH9ticIiaaRGNhgmJ3iagaOAfgZNeZlHpT2OaWGG71xfvxM1ydDZ4wIOeuK/0";
 id = 707;
 "is_dashang" = 0;
 "is_message" = 1;
 "is_message_m" = 0;
 "is_self" = 0;
 "member_id" = 1173;
 mp3 = "http://m.tuoninfu.com/Public/upload/media/20151229/14513686462539.mp3";
 nickname = Haimi;
 play = 6;
 sid = 896;
 source = 1;
 status = 1;
 "teacher_content" = "6,5,3,2,";
 "teacher_headimgurl" = "http://wx.qlogo.cn/mmopen/C3rcJRaeffTSnIpIf0PPcQVWCG6q4jJJLHcjiacQ3S3QWlNFFZf4yvFiau63Lrdo6dwLlNvrqZGYKxCkIKBkr0kWk1tqbVQMKQ/0";
 "teacher_join_id" = 20;
 "teacher_join_time" = 1451368770;
 "teacher_member_id" = 20;
 "teacher_mp3" = "http://m.tuoninfu.com/Public/upload/media/20151229/14513689134197.mp3";
 "teacher_nickname" = Joy;
 "teacher_time" = 1451368927;
 time = 43;  时长
 type = 1; 托福雅思
 updatetime = 1451368646;
 */
#import <JSONModel/JSONModel.h>

@interface VoiceInfo : JSONModel

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *is_self;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *mp3;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *headimgurl;
@property(nonatomic,copy)NSString *teacher_member_id;
@property(nonatomic,copy)NSString *teacher_nickname;
@property(nonatomic,copy)NSString *teacher_headimgurl;
@property(nonatomic,copy)NSString *fen1;
@property(nonatomic,copy)NSString *fen2;
@property(nonatomic,copy)NSString *fen3;
@property(nonatomic,copy)NSString <Optional>*fen4;
@property(nonatomic,copy)NSString *fen;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *is_dashang; //是否打赏
@property(nonatomic,copy)NSString *is_message;
@property(nonatomic,copy)NSString *member_id;




@end
