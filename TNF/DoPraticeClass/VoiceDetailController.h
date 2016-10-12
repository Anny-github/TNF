//
//  VoiceDetailController.h
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface VoiceDetailController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,AVAudioPlayerDelegate,UITextViewDelegate,RecordViewDelegate>

@property (retain, nonatomic) AVAudioPlayer *player;
@property (nonatomic,retain)VoicesModel *model;
@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,retain)NSMutableArray *messages;


@end
