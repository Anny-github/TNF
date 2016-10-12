//
//  CustomRecordView.m
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.


#import "CustomRecordView.h"

@interface CustomRecordView ()
{
    Recoder *recoder;
    UILabel *timeLabel;
    int state;
    int playtime;
    NSTimer *timer;
    NSTimer *playTimer;
    
    UIView *roundView; //圆形图
    UIImageView *recordBgImgV;//背景图

    UIButton *recordBtn; //录音和播放按钮
    UIImageView *animationImgV; //动画image
    
    UIButton *secretBtn; //匿名button
    UIButton *reRecordBtn; //重录butotn
    UIButton *publicBtn; //公开发布button
    UIButton *cancelBtn; //取消button
    
}


@end
@implementation CustomRecordView

+ (CustomRecordView *)sharedManager
{
    static CustomRecordView *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithTimes:(int)times
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        state = 0;
        recoder = [[Recoder alloc] initWithTimes:times];
        recoder.delegate = self;
        _times = times;
        [self initViews];
        
    }
    return self;
}

- (void)initViews
{
    UIImage *img = [UIImage imageNamed:@"recordBeginBg"];

    self.frame = CGRectMake(0, kScreenHeight - img.size.height - 60, kScreenWidth, kScreenWidth/3.0*2 + 60);
    self.backgroundColor = [UIColor clearColor];
    
//    roundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/3.0*2, kScreenWidth/3.0*2)];
    roundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];

    roundView.backgroundColor = [UIColor lightGrayColor];
    roundView.layer.cornerRadius = roundView.width/2.0;
    roundView.layer.masksToBounds = YES;
    [self addSubview:roundView];
    roundView.center = CGPointMake(self.width/2.0, self.height - kScreenWidth/3.0);
    
    //背景图
    recordBgImgV = [[UIImageView alloc]initWithFrame:roundView.bounds];
    recordBgImgV.image = [UIImage imageNamed:@"recordBeginBg"];
    recordBgImgV.userInteractionEnabled = YES;
    [roundView addSubview:recordBgImgV];
    recordBgImgV.contentMode = UIViewContentModeCenter;
//
    //动态imag
    animationImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, roundView.height/2.0 - 20*ratioHeight, roundView.width, 40*ratioHeight)];
    [roundView addSubview:animationImgV];
    animationImgV.userInteractionEnabled = YES;
//    animationImgV.backgroundColor = [UIColor purpleColor];
    
    
    //中间button
    recordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, roundView.width/3.0, roundView.width/3.0)];
    [recordBtn setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [recordBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:recordBtn];
    recordBtn.center = CGPointMake(roundView.width/2.0, roundView.width/2.0);
//    recordBtn.backgroundColor = [UIColor whiteColor];
    
    //录音完毕，四个按钮
    secretBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, roundView.height/2.0 - 20*ratioHeight, roundView.width/4.0, 40*ratioHeight)];
//    [secretBtn setTitle:[NSString stringWithFormat:@"匿名\n发布"] forState:UIControlStateNormal];
//    secretBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    [secretBtn setTitleColor:[MyColor colorWithHexString:@"0xF7226E"] forState:UIControlStateNormal];
    secretBtn.tag = 1000;
    [secretBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:secretBtn];
    
    reRecordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,5, roundView.width/4.0, 40*ratioHeight)];
//    [reRecordBtn setTitle:[NSString stringWithFormat:@"重录"] forState:UIControlStateNormal];
    [reRecordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [roundView addSubview:reRecordBtn];
    reRecordBtn.centerX = roundView.width/2.0;
    reRecordBtn.tag = 1001;
    [reRecordBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    publicBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, roundView.height/2.0 - 20*ratioHeight, roundView.width/4.0, 40*ratioHeight)];
   
//    [publicBtn setTitle:[NSString stringWithFormat:@"公开\n发布"] forState:UIControlStateNormal];
//    [publicBtn setTitleColor:[MyColor colorWithHexString:@"0xF7226E"] forState:UIControlStateNormal];
//    publicBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;

    [roundView addSubview:publicBtn];
    publicBtn.right = roundView.width;
    publicBtn.tag = 1002;
    [publicBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, roundView.width/4.0, 40*ratioHeight)];
////    [cancelBtn setTitle:[NSString stringWithFormat:@"取消"] forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [roundView addSubview:cancelBtn];
    cancelBtn.centerX = roundView.width/2.0;
    cancelBtn.bottom = roundView.height-5;
    cancelBtn.tag = 1003;
    [cancelBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    

    //隐藏
    secretBtn.hidden = YES;
    reRecordBtn.hidden = YES;
    publicBtn.hidden = YES;
    cancelBtn.hidden = YES;
    
}

#pragma makr --发布、重录、取消
-(void)finishBtnAction:(UIButton*)btn{
    switch (btn.tag) {
        case 1000: //匿名发布
        {
            [recoder endPlay];
            NSData *recordeData =  [self MP3];
            [self.delegate recordMp3Data:recordeData withTime:[NSString stringWithFormat:@"%d",recoder.times] bePublic:NO];
        }
            
            break;
        case 1001: //重录
        {
            //1.背景图改变
            [self deleteFile];
            [recoder endPlay];
            [self showAnimation]; //隐藏四个按钮
            state = 0;
            [self buttonAction:recordBtn];
            
        }
            break;
            
        case 1002: //公开发布
        {
            [recoder endPlay];
            NSData *recordeData =  [self MP3];
            [self.delegate recordMp3Data:recordeData withTime:[NSString stringWithFormat:@"%d",recoder.times] bePublic:YES];
        }
            break;
            
        case 1003: //取消
        {
            [recoder endPlay];
            [self hiddens];
            [self deleteFile];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark --------获取MP3文件
- (NSData *)MP3
{
    
    NSData *fileData = [NSData dataWithContentsOfFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/taskRecordAudioView.mp3"] options:NSDataReadingMappedIfSafe error:nil];
    return fileData;
}

-(void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    //文件名
    NSString *uniquePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/taskRecordAudioView.mp3"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"没有");
        return ;
    }else {
        NSLog(@" 有");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
        
    }
}


- (void)buttonAction:(UIButton *)sender
{
    if (state == 0){
//        recordBgImgV.image = [
        //录音动画开始
//        [animationImgV startAnimating];
        //       开始录音
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        
        state = 1;
        timeLabel.text = [NSString stringWithFormat:@"%d秒",self.times];
        [recoder startRecoder];
        
        
        
    }else if(state == 1){
        //  录制声音结束
        recordBgImgV.image = [UIImage imageNamed:@"recordStopBg"];
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        [recoder endRecoder];
        timeLabel.hidden = YES;
        state = 2;
        [self showAnimation]; //四个按钮出现，背景改变
        
        [timer invalidate];
        
        
    }else if(state == 2){
        //  开始播放
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        state = 3;
        [recoder startPlay];
        playtime = 0;
        //        timeLabel.hidden = NO; //不显示播放时间进度
        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountingRecord) userInfo:nil repeats:YES];
        
        
    }else if (state == 3){
        //播放结束
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        state = 2;
        [recoder endPlay];
        playtime = 0;
        timeLabel.hidden = YES;
        //        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        [playTimer invalidate];
        
    }
    
}



- (void)timerCountingRecord
{
    playtime++;
    
    timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
    
}



#pragma mark --RecoderDelegate--
- (void)playEnd
{
    [recordBtn setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    timeLabel.hidden = YES;
    state = 2;
    playtime = 0;
    [playTimer invalidate];
    
}

- (void)recordtime:(int)time
{
    
    timeLabel.text = [NSString stringWithFormat:@"%d秒",self.times - time];
    
}

- (void)recordEnd
{
    
    [timer invalidate];
    
    [self setNeedsDisplay];
    
    [recordBtn setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    [recoder endRecoder];
    timeLabel.hidden = YES;
    state = 2;
    [self showAnimation];
    
}

- (void)showAnimation{
    
    if (state == 0) {
        [UIView animateWithDuration:1 animations:^{
            
            secretBtn.hidden = YES;
            reRecordBtn.hidden = YES;
            publicBtn.hidden = YES;
            cancelBtn.hidden = YES;
            animationImgV.hidden = NO;
            
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            
            secretBtn.hidden = NO;
            reRecordBtn.hidden = NO;
            publicBtn.hidden = NO;
            cancelBtn.hidden = NO;
            animationImgV.hidden = YES;
            
        }];
    }
    
    
   
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    state = 0;
    [self buttonAction:recordBtn];
    
    
}

- (void)hiddens
{
    [self removeFromSuperview];
    
}


@end
