//
//  VoiceDetailController.m
//  TNF
//
//  Created by wss on 16/5/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "VoiceDetailController.h"
#import "UIImage+ImageEffects.h"
#import "TitleView.h"
#import "TeachCell.h"
#import "SbjectCell.h"
#import "LDZMoviePlayerController.h"
#import "StarView.h"
#import "FXBlurView.h"
#import "TagViewController.h"
#import "UIImage+BoxBlur.h"
#import "MessageFrame.h"
#import "MessageCell.h"
#import "Message.h"

@interface VoiceDetailController ()
{
    CGFloat _float_y;
    BOOL _issend;
    
    UITableView *_tableView;
    UIView *_ViodeView;
    UIButton *playBtn;
    NSTimer *recoderTimer;
    int _counterTime;
    UILabel *timeLabel;
    int subType;
    UIView *progressView;
    
    NSMutableArray  *_allMessagesFrame;
    UITextView *_messageField;
    UIView *view;
    UIButton *senderButton;
    RecoderView *recode;
    
    VoiceDetailModle *_voiceDetail;
    
}

@end

@implementation VoiceDetailController

//
//  WhizkidController.m
//  TNF
//
//  Created by 李江 on 16/1/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.text = @"答题录音";
    self.messages = [NSMutableArray array];
    _allMessagesFrame = [NSMutableArray array];
    _counterTime = 0;
    [self _loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bubbleShouldStop:) name:@"FSVoiceBubbleShouldStopNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoDonghua) name:Noti_VideoDonghua object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:Noti_tiaozhuan object:nil];
    
    _issend = YES;
    
    //首页红点消失
    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_MyTestAnswerd object:@{@"myTest":@"0"}];
    
    
}

- (void)action:(NSNotification *)notification
{
    self.ID = notification.object;
    [self _loadData];
    
    
}

//通知动画
- (void)VideoDonghua
{
    
    [UIView animateWithDuration:.5 animations:^{
        
        _ViodeView.height = ratioWidth*40/2;
        _ViodeView.width = ratioWidth*40/2;
        _ViodeView.left = kScreenWidth-70*ratioWidth/2;
        _ViodeView.top = _float_y;
    } completion:^(BOOL finished) {
        _ViodeView.alpha = 0;
    }];
    
}


#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    // 1.取得弹出后的键盘frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height - 64;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
}

#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    // 1.取得弹出后的键盘frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
    }];
}

#pragma mark - Nofication
- (void)bubbleShouldStop:(NSNotification *)notification
{
    if (_player.isPlaying) {
        [_player stop];
        [playBtn.imageView stopAnimating];
        _player.currentTime = 0;
        _player = nil;
        [recoderTimer invalidate];
        _counterTime = 0;
        progressView.width = kScreenWidth;
        int time = [_voiceDetail.info.time intValue];
        timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",time / 60 ,time%60];
        
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FSVoiceBubbleShouldStopNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)tapFirst
{
    [self.view endEditing:YES];
    
}


- (void)_initViews
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - 64 ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = YES;
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tapfist = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFirst)];
    [_tableView addGestureRecognizer:tapfist];
    
    
    
    _ViodeView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-70*ratioWidth/2, 275 * ratioHeight + _voiceDetail.mp3_list.count * 35 + 60 + 40* ratioHeight , ratioWidth*40/2, ratioWidth*40/2)];
    _ViodeView.alpha = 0;
    _ViodeView.backgroundColor = UIColor6(正文小字);
    [self.view addSubview:_ViodeView];
    
    
    //我自己的声音 且 已被老师点评，显示评论tabBar，tableViewFooterView
    if(_voiceDetail.mp3_list.count != 0){
        
        if ([_voiceDetail.info.is_self isEqualToString:@"1"]) {
            
            _tableView.height = self.view.height - 64 - 40;
            view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 40, kScreenWidth, 40)];
            
            senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [senderButton setImage:[UIImage imageNamed:@"语音回复按钮"] forState:UIControlStateNormal];
            [senderButton addTarget:self action:@selector(buttonAC:) forControlEvents:UIControlEventTouchUpInside];
            senderButton.frame = CGRectMake(10, 2, 44.5, 36);
            [view addSubview:senderButton];
            
            //设置textField输入起始位置
            _messageField = [[UITextView alloc] initWithFrame:CGRectMake(senderButton.right  + 10,5 , kScreenWidth - 74.5, 30)];
            _messageField.layer.borderColor  = [MyColor colorWithHexString:@"#dcdcdc"].CGColor; //要设置的颜色
            _messageField.font = [UIFont systemFontOfSize:14];
            _messageField.layer.borderWidth = .5; //要设置的描边宽
            
            _messageField.layer.masksToBounds = YES;
            _messageField.layer.cornerRadius = 2;
            _messageField.backgroundColor = [UIColor whiteColor];
            _messageField.bounces = NO;
            //    _messageField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
            //    _messageField.leftViewMode = UITextFieldViewModeAlways;
            
            _messageField.delegate = self;
            _messageField.returnKeyType = UIReturnKeySend;
//            [view addSubview:_messageField];
            _tableView.tableFooterView = view;
            [self.view addSubview:view];
            NSLog(@"---subviews===%@",self.view.subviews);
        }
        
    }
    
}

- (void)mp3button:(UIButton *)sender
{
    
    if (_player.playing) {
        
        [_player stop];
        [sender.imageView stopAnimating];
        _player.currentTime = 0;
        _player = nil;
        [recoderTimer invalidate];
        _counterTime = 0;
        progressView.width = kScreenWidth;
        int time = [_voiceDetail.info.time intValue];
        timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",time / 60 ,time%60];
        NSLog(@"停止");
        
    }else{
        NSLog(@"播放");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FSVoiceBubbleShouldStopNotification" object:nil];
        if (!_voiceDetail.info.mp3) {
            [TNFPublicTool HUDWithString:@"地址不存在"];
            return;
        }
        if (!_player.playing) {
            
            NSError *error = nil;
            //选取音频对象
            BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
            if(success)
            {
                NSLog(@"选取音频对象成功！");
                
                //设置按钮状态
                NSError *playbackErroor = nil;
                //文件路径选取
                NSURL *url = [[NSURL alloc]initWithString:_voiceDetail.info.mp3];
                NSData *audioData = [NSData dataWithContentsOfURL:url];              [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                if (audioData) {
                    //初始化播放器
                    _player = [[AVAudioPlayer alloc] initWithData:audioData error:&playbackErroor];
                    _player.delegate = self;
                    _player.numberOfLoops = 0;
                    if ([_player prepareToPlay] && [_player play])
                    {
                        
                        recoderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountingRecord) userInfo:nil repeats:YES];
                        
                        sender.imageView.animationImages = @[[UIImage imageNamed:@"b1"],[UIImage imageNamed:@"b2"],[UIImage imageNamed:@"b3"]];
                        sender.imageView.animationDuration = 1;
                        [sender.imageView startAnimating];
                        
                        
                    }
                    else
                    {
                        [TNFPublicTool HUDWithString:@"播放失败"];
                        return;
                        
                    }
                    
                }
            }
            
        }
        
        
    }
    
    
    
    
}

//录音计数函数
-(void)timerCountingRecord
{
    _counterTime+=1;//每次加一秒
    timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",_counterTime / 60,_counterTime % 60];
    progressView.width = kScreenWidth * _counterTime /[_voiceDetail.info.time intValue];
    
}

#pragma mark - AVAudioPlayer Delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [player pause];
    
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    [player play];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    _counterTime = 0;
    [playBtn.imageView stopAnimating];
    [recoderTimer invalidate];
    progressView.width = kScreenWidth;
    int time = [_voiceDetail.info.time intValue];
    timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",time / 60 ,time%60];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player stop];
    _counterTime = 0;
    [playBtn.imageView stopAnimating];
    [recoderTimer invalidate];
    progressView.width = kScreenWidth;
    int time = [_voiceDetail.info.time intValue];
    timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",time / 60 ,time%60];
    
}

#pragma mark ------------UITableView Delegate------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(_voiceDetail.mp3_list.count == 0){
        
        return 0;
    }
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_voiceDetail.mp3_list.count == 0){
        
        return 0;
        
    }else{
        
        if(section == 0){
            
            return 3;
            
        }else{
            
            return _allMessagesFrame.count;
        }
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) { //老师
            
            TeachCell  *cell = [[TeachCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.voiceDetail = _voiceDetail;
            return cell;
            
        }else if (indexPath.row == 1){ //星星视图
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIView *vieSS = [[UIView alloc]initWithFrame:CGRectZero];
            NSArray *subjectCN;
            int type;
            if ([_voiceDetail.info.type isEqualToString:@"1"]) {
                
                subjectCN = @[@{@"title":@"Delivery"},@{@"title":@"Topic Development"},@{@"title":@"Language Use"}];
                type = 1;
                
            }else{
                
                type = 2;
                //雅思
                subjectCN = @[@{@"title":@"Fluency"},@{@"title":@"Vocabuary"},@{@"title":@"Grammar"},@{@"title":@"Pronunciation"}];
            }
            [subjectCN enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                int count;
                
                NSArray *fen;
                
                if (type == 2) {
                    count = 9;
                    fen = @[_voiceDetail.info.fen1 ,_voiceDetail.info.fen2 ,_voiceDetail.info.fen3 ,_voiceDetail.info.fen4];
                }else{
                    
                    count = 4;
                    fen = @[_voiceDetail.info.fen1,_voiceDetail.info.fen2,_voiceDetail.info.fen3];
                }
                
                
                UILabel *delivery = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*20/2,(ratioHeight*10+ratioHeight*30/2)*idx+ratioHeight*40/2, ratioWidth*130/2, ratioHeight*30/2) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:30+idx];
                delivery.text = obj[@"title"];
                [vieSS addSubview:delivery];
                [delivery sizeToFit];
                
                
                NSInteger gray = 3;
                //星星视图
                StarView *start = [[StarView alloc]initWithFrame:CGRectMake(delivery.right+ratioWidth*20/2,(ratioHeight*10+ratioHeight*15)*idx+ratioHeight*40/2 , ratioHeight*30/2*gray+((gray-1)*(ratioWidth*10/2)), ratioHeight*30/2) starmore:[fen[idx] intValue] Grayindex:count];
                start.tag = 2000+idx;
                start.userInteractionEnabled = YES;
                [vieSS addSubview:start];
                
            }];
            
            //视频
            UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            videoButton.frame = CGRectMake(kScreenWidth-70*ratioWidth/2, ratioHeight*20/2, 22, 22);
            [videoButton setImage:[UIImage imageNamed:@"play_05"] forState:UIControlStateNormal];
            [videoButton addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
            //        [vieSS addSubview:videoButton];
            [cell.contentView addSubview:videoButton];
            [cell.contentView addSubview:vieSS];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
            
        }else if(indexPath.row == 2){ //
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            for (int i = 0; i < _voiceDetail.com_list.count; i ++) {
                NSDictionary *dic = _voiceDetail.com_list[i];
                UIButton *label = [[UIButton alloc] initWithFrame:CGRectMake(10 + i % 3 * (( kScreenWidth - 40 ) / 3.0 + 10),20 + i / 3 * 40,(kScreenWidth - 40 ) / 3.0, 30)];
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 15;
                label.titleLabel.font = [UIFont systemFontOfSize:14];
                [label setTitle:dic[@"title"] forState:UIControlStateNormal];
                [label setBackgroundColor:[MyColor colorWithHexString:[NSString stringWithFormat:@"0x%@",dic[@"color"]]]];
                label.tag = [dic[@"id"] integerValue];
                [label addTarget:self action:@selector(biaoqian:) forControlEvents:UIControlEventTouchUpInside];
                [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell addSubview:label];
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth + 100, 0, 0);
            return cell;
            
            
        }else{
            
            static NSString *identifire = @"cellMessage";
            SbjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[SbjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = [UIColor whiteColor];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dataList = _voiceDetail.comment_list;
            if( _voiceDetail.info.is_self){
                cell.isSelf = YES;
            }else{
                cell.isSelf = NO;
            }
            cell.ID = _voiceDetail.subject_info.ID;
            return cell;
            
        }
        
        
    }else{ //section == 1
        
        
        static NSString *CellIdentifier = @"Cell";
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // 设置数据
        cell.messageFrame = _allMessagesFrame[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return _voiceDetail.mp3_list.count * 35 + 60;
            
        }else if(indexPath.row == 1){
            
            if ([_voiceDetail.info.type isEqualToString:@"2"]) {
                //托福
                return 140 * ratioHeight;
            } else {
                return 105 * ratioHeight;
                
            }
            
        }else {
            
            if(_voiceDetail.com_list.count == 0 || _voiceDetail.com_list == nil){
                
                return 0;
            }
            if(_voiceDetail.com_list.count % 3 == 0){
                
                return _voiceDetail.com_list.count/ 3 * 40 + 30;
                
            }else {
                return ((_voiceDetail.com_list.count  + 3)/ 3) * 40 + 30;
            }
        }
    }else{
        
        return [_allMessagesFrame[indexPath.row] cellHeight];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 30;
        
    }else{
        
        return .1;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *hview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        label.text = @"老师点评";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [hview addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 200-10, 0, 200, 30)];
        label1.text = @"综合评分3.4";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textAlignment = NSTextAlignmentRight;
        [hview addSubview:label1];
        return hview;
    }else{
        
        return nil;
    }
    
}


#pragma mark ---弱点标签点击--
- (void)biaoqian:(UIButton *)sender
{
    
    TagViewController *tagVC = [[TagViewController alloc]init];
    tagVC.ID = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self.navigationController pushViewController:tagVC animated:YES];
    
    NSLog(@"弱点标签点击事件");
    
}

#pragma mark - 代理方法
#pragma mark-- tabelView滑动--------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y ;
    _float_y = 275 * ratioHeight + _voiceDetail.mp3_list.count * 35 + 60 + 40* ratioHeight  - offsetY;
    _ViodeView.top =  _float_y;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

#pragma mark -- 视频点击事件--------------
- (void)Button:(UIButton *)sender{
    
    [UIView animateWithDuration:.5 animations:^{
        
        _ViodeView.width = kScreenWidth;
        _ViodeView.height = kScreenHeight;
        _ViodeView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
        
        _ViodeView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        //音频播放显示恢复原状
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FSVoiceBubbleShouldStopNotification" object:nil];
        [_player stop];
        _counterTime = 0;
        [playBtn.imageView stopAnimating];
        [recoderTimer invalidate];
        progressView.width = kScreenWidth;
        int time = [_voiceDetail.info.time intValue];
        timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d",time / 60 ,time%60];
        
        //视频播放进入
        LDZMoviePlayerController *moviewPlayerVC = [[LDZMoviePlayerController alloc] init];
        
        /*
         //  播放本地
         moviewPlayerVC.movieURL = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"5540385469401b10912f7a24-6.mp4"]];
         */
        
        //  播放网络
        //        NSString *urlString = @"http://mw2.dwstatic.com/2/8/1528/133366-99-1436362095.mp4";
        
        NSURL *URL = [NSURL URLWithString:_voiceDetail.mp4Url];
        moviewPlayerVC.movieURL = URL;
        [self presentViewController:moviewPlayerVC animated:NO completion:nil];
        
        NSLog(@"视频点击事件");
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

#pragma mark --数据请求
- (void)_loadData
{
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"id":self.ID,@"member_id":useid,@"page":@"1"};
    [TNFPublicTool showHUDWithView:self.view];
    [TNFHttpRequest getVoiceDetail:params completeHandle:^(id result) {
        [TNFPublicTool hideHUDWithView:self.view];

        _voiceDetail = result;
        [self _initViews];

        
    }];
 
    
    
    
}

#pragma mark ------------recoderViewDelegate-------
- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time
{
    if ([time intValue] < 25) {
        [TNFPublicTool HUDWithString:@"录音时长太短，请重新录制"];
        [recode hiddens];
        return;
    }
    
    [WXDataService postMP3:Url_uploadImgApp params:nil fileData:data finishBlock:^(id result) {
        
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
                [recode hiddens];
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            [self loadMp3:dic[@"path"]];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
        [recode hiddens];
    }];
    
}

- (void)loadMp3:(NSString *)path
{
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"id":_voiceDetail.subject_info.ID,@"mp3":path};
    [WXDataService requestAFWithURL:Url_mp3CommentSave params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            NSLog(@"ggggg%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [recode hiddens];
                [TNFPublicTool HUDWithString:result[@"msg"]];
                
                return;
            }
            
            [self addMessageWithMessage:result[@"result"]];
            [recode hiddens];
            
        }
    } errorBlock:^(NSError *error) {
        
        [recode hiddens];
        NSLog(@"%@",error);
    }];
    
    
    
}

#pragma mark 给数据源增加内容
- (void)addMessageWithMessage:(NSDictionary *)dic
{
    Message *addmessage =  [[Message alloc] init];
    addmessage.dict = dic;
    
    
    MessageFrame *messageFrame = [[MessageFrame alloc] init];
    messageFrame.message = addmessage;
    
    [_allMessagesFrame addObject:messageFrame];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:1];
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)sendMessage
{
    if (_messageField.text.length == 0) {
        return;
    }
    NSString *text = _messageField.text;
    _messageField.text = @"";
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"id":_voiceDetail.subject_info.ID,@"content":text};
    
    [WXDataService requestAFWithURL:Url_mp3CommentSave params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            NSLog(@"ggggg%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
                _messageField.text = text;
                return;
            }
            
            [self addMessageWithMessage:result[@"result"]];
            
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

#pragma mark ----------录音回复--------
- (void)buttonAC:(UIButton *)sender
{
    [self.view endEditing:YES];
    recode = [[RecoderView alloc] initWithTimes:60];
    recode.delegate = self;
    [recode show];
    
}

#pragma mark - 文本框代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if(textView.text.length == 0){
            
            return NO;
        }
        
        [self sendMessage];
        return NO;
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

