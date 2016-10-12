//
//  WhizkidController.h
//  TNF
//
//  Created by 李江 on 16/1/5.
//  Copyright © 2016年 刘翔. All rights reserved.
/**
 *  已评分的录音详情，有老师评论录音、评分星星、标签、同学及老师的回复
 */

#import "BaseViewController.h"
#import "VoiceModel.h"
#import "Info.h"

@interface WhizkidController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,AVAudioPlayerDelegate,UITextViewDelegate,RecordViewDelegate>

@property (retain, nonatomic) AVAudioPlayer *player;
@property (nonatomic,retain)VoiceModel *model;
@property (nonatomic,retain)NSString *ID;  //优等声ID
@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,retain)Info *info;
@property (nonatomic,retain)NSDictionary *dic;
@property (nonatomic,retain)NSArray *mp3_list;
@property (nonatomic,retain)NSArray *com_list;
@property (nonatomic,retain)NSMutableArray *messages;
@property (nonatomic,copy)NSString *mp4Url;
@property (nonatomic,copy)NSString *mp3Url;
@property (nonatomic,assign)BOOL isSelf;

@end
