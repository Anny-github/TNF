//
//  RecoderView.m
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "RecoderView.h"
#import "UIImage+GIF.h"

@implementation RecoderView

+ (RecoderView *)sharedManager
{
    static RecoderView *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
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
    
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    self.backgroundColor = [UIColor clearColor];
    
    giveUpbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    giveUpbutton.frame = CGRectMake(25*ratioHeight, self.height - 30 * ratioHeight - 45 * ratioHeight, (kScreenWidth - 50 * ratioHeight) / 2.0, 45 * ratioHeight);
    [giveUpbutton setTitle:@"放弃" forState:UIControlStateNormal];
    [giveUpbutton setBackgroundColor:UIColor9(白色)];
    giveUpbutton.layer.borderWidth = 2.0;
    giveUpbutton.layer.borderColor = [MyColor colorWithHexString:@"#0172fe"].CGColor;
    [giveUpbutton setTitleColor:[MyColor colorWithHexString:@"#0172fe"] forState:UIControlStateNormal];
    [giveUpbutton addTarget:self action:@selector(giveUp:) forControlEvents:UIControlEventTouchUpInside];
    [giveUpbutton.layer setMasksToBounds:YES];
    [giveUpbutton.layer setCornerRadius:45 * ratioHeight / 2.0];//
    
    fabuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fabuButton.frame = CGRectMake(kScreenWidth / 2.0, self.height - 30 * ratioHeight - 45 * ratioHeight, (kScreenWidth - 50 * ratioHeight) / 2.0, 45 * ratioHeight);
    [fabuButton setBackgroundColor:[MyColor colorWithHexString:@"#0172fe"]];
    [fabuButton setTitle:@"发布" forState:UIControlStateNormal];
    [fabuButton addTarget:self action:@selector(fabu1:) forControlEvents:UIControlEventTouchUpInside];
    [fabuButton.layer setMasksToBounds:YES];
    [fabuButton.layer setCornerRadius:45 * ratioHeight / 2.0];//
//    fabuButton.hidden = YES;

//    fabuButton.alpha = 0;
//    [self addSubview:fabuButton];

    
    

    playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, self.height - 20 * ratioHeight - 65 * ratioHeight, 65 * ratioHeight, 65 * ratioHeight);
    [playbutton setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    playbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [self addSubview:playbutton];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, playbutton.top - 40, kScreenWidth, 30)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont fontWithName:@"Arial" size:20];
    timeLabel.textColor = [MyColor colorWithHexString:@"0xF7226E"];
    timeLabel.text = @"0";
    [self addSubview:timeLabel];
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, timeLabel.top - 30 * ratioHeight, kScreenWidth, 17 * ratioHeight)];
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.font = [UIFont boldSystemFontOfSize:17];
    stateLabel.textColor = [MyColor colorWithHexString:@"0xF7226E"];
    [self addSubview:stateLabel];
    
    //
    tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, stateLabel.bottom + 10, kScreenWidth, 15 * ratioHeight)];
    tishiLable.backgroundColor = [UIColor clearColor];
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.font = [UIFont systemFontOfSize:15];
    tishiLable.text = @"";
    tishiLable.textColor = [MyColor colorWithHexString:@"0xF7226E"];
    [self addSubview:tishiLable];
    

    
//    stLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, playbutton.top - 35, kScreenWidth, 15 * ratioHeight)];
//    stLabel.backgroundColor = [UIColor clearColor];
//    stLabel.textAlignment = NSTextAlignmentCenter;
//    stLabel.font = [UIFont systemFontOfSize:15];
//    stLabel.textColor = [MyColor colorWithHexString:@"0xF7226E"];
//    stLabel.text = @"试听";
//    stLabel.hidden = YES;
//    [self addSubview:stLabel];

    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"录音动画" ofType:@"gif"]];
    
    CGRect frame = CGRectMake(20 * ratioWidth,timeLabel.bottom + 40 * ratioHeight,kScreenWidth - 40 * ratioWidth,40 * ratioWidth);
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [UIImage sd_animatedGIFWithData:gif];
    [image sd_animatedImageByScalingAndCroppingToSize:CGSizeMake(kScreenWidth - 40 * ratioWidth,40 * ratioWidth)];
    imageView.image = image;
    imageView.hidden = YES;
//    [self addSubview:imageView];
    
    
    [playbutton setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
    stateLabel.hidden = YES;
    tishiLable.hidden = YES;
    state = 1;
    timeLabel.text = [NSString stringWithFormat:@"%d秒",self.times];
//    [recoder startRecoder];
    
    imageView.hidden = NO;
    for(int i=0; i<SOUND_METER_COUNT; i++) {
        soundMeters[i] = SILENCE_VOLUME;
    }
    hudRect = CGRectMake(self.center.x - (HUD_SIZE / 2), self.center.y - (HUD_SIZE / 2), HUD_SIZE, HUD_SIZE);
    
    


}

#pragma mark --开始录音，设置音量动画
-(void)setVoiceAnimation{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateMetersOftimer) userInfo:nil repeats:YES];
}

#pragma mark -------发布----------
- (void)fabu1:(UIButton *)sender
{
    [recoder endPlay];
    NSData *recordeData =  [self MP3];
    [self.delegate recordfabuMp3Data:recordeData withTime:[NSString stringWithFormat:@"%d",recoder.times]];


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


- (void)giveUp:(UIButton *)sender
{
    [recoder endPlay];
    [self hiddens];
    [self deleteFile];
    
}

- (void)buttonAction:(UIButton *)sender
{
    if (state == 0){
        
        //开始录音，设置音量动画
        [self setVoiceAnimation];
        
//       开始录音
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        stateLabel.hidden = YES;
        tishiLable.hidden = YES;
        
        state = 1;
        timeLabel.text = [NSString stringWithFormat:@"%d秒",self.times];
        [recoder startRecoder];
        imageView.hidden = NO;
        
      
        
    }else if(state == 1){
//        录制声音结束
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        [recoder endRecoder];
        timeLabel.hidden = YES;
        tishiLable.hidden = NO;
        stateLabel.hidden = NO;
        tishiLable.text = [NSString stringWithFormat:@"%.2d:%.2d",recoder.times/60,recoder.times%60];
        stateLabel.text = @"录音结束";
//        stLabel.hidden = NO;
        state = 2;
        [self showAnimation];
        imageView.hidden = YES;
        
        [timer invalidate];
        [self setNeedsDisplay];
        
    
    }else if(state == 2){
//       开始播放
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        state = 3;
        [recoder startPlay];
        playtime = 0;
//        timeLabel.hidden = NO; //不显示播放时间进度
        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountingRecord) userInfo:nil repeats:YES];
        imageView.hidden = NO;

    
    }else if (state == 3){
        //播放结束
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        state = 2;
        [recoder endPlay];
        playtime = 0;
        timeLabel.hidden = YES;
//        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        [playTimer invalidate];
        imageView.hidden = YES;
       
    }

}

#pragma mark --
- (void)updateMetersOftimer{
    [recoder.audioRecoder updateMeters];
    if ([recoder.audioRecoder averagePowerForChannel:0] < -SILENCE_VOLUME) {
        [self addSoundMeterItem:SILENCE_VOLUME];
        return;
        
    }
    [self addSoundMeterItem:[recoder.audioRecoder averagePowerForChannel:0]];

    
}
    


- (void)addSoundMeterItem:(int)lastValue{
    for(int i=0; i<SOUND_METER_COUNT - 1; i++) {
        soundMeters[i] = soundMeters[i+1];
    }
    soundMeters[SOUND_METER_COUNT - 1] = lastValue;
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing operations

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    int baseLine = playbutton.top+playbutton.height/2.0;
    static int multiplier = 1;
    int maxLengthOfWave = 45;
    int maxValueOfMeter = 400;
    int yHeights[6];
    float segement[6] = {0.05, 0.2, 0.35, 0.25, 0.1, 0.05};
    
    [[MyColor colorWithHexString:@"0xF7226E"] set];
    CGContextSetLineWidth(context, 2.0);
    
    
    for(int x = SOUND_METER_COUNT - 1; x >= 0; x--)
    {
        int multiplier_i = ((int)x % 2) == 0 ? 1 : -1;
        CGFloat y = ((maxValueOfMeter * (maxLengthOfWave - abs(soundMeters[(int)x]))) / maxLengthOfWave);
        yHeights[SOUND_METER_COUNT - 1 - x] = multiplier_i * y * segement[SOUND_METER_COUNT - 1 - x]  * multiplier+ baseLine;
        //NSDLOG(@"i:%d, f:%d",5 + x - SOUND_METER_COUNT + 1, yHeights[5 + x - SOUND_METER_COUNT + 1]);
    }
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:2.0 alpha:0.8 percent:1.0 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:1.0 alpha:0.4 percent:0.66 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:1.0 alpha:0.2 percent:0.33 segementArray:segement];
    multiplier = -multiplier;
}

- (void) drawLinesWithContext:(CGContextRef)context BaseLine:(float)baseLine HeightArray:(int*)yHeights lineWidth:(CGFloat)width alpha:(CGFloat)alpha percent:(CGFloat)percent segementArray:(float *)segement{
    
    CGFloat start = 0;
    
    if (timer.isValid) {
        [[MyColor colorWithHexString:@"0xF7226E"] set];

    }else{
        [[UIColor clearColor]set];
    }
    
    CGContextSetLineWidth(context, width);
    
    for (int i = 0; i < 6; i++) {
        if (i % 2 == 0) {
            CGContextMoveToPoint(context, start, baseLine);
            
            CGContextAddCurveToPoint(context, self.width *segement[i] / 2 + start, (yHeights[i] - baseLine)*percent + baseLine, self.width *segement[i] + self.width *segement[i + 1] / 2 + start, (yHeights[i + 1] - baseLine)*percent + baseLine,self.width *segement[i] + self.width *segement[i + 1] + start , baseLine);
            start += self.width *segement[i] + self.width *segement[i + 1];
        }
    }
    
    CGContextStrokePath(context);
}


- (void)timerCountingRecord
{
    playtime++;
    
    timeLabel.text = [NSString stringWithFormat:@"%d",playtime];

}



#pragma mark --RecoderDelegate--
- (void)playEnd
{
    [playbutton setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    timeLabel.hidden = YES;
    state = 2;
    playtime = 0;
    [playTimer invalidate];
    imageView.hidden = YES;

}

- (void)recordtime:(int)time
{

    timeLabel.text = [NSString stringWithFormat:@"%d秒",self.times - time];

}

- (void)recordEnd
{
    
     [timer invalidate];
    
     [self setNeedsDisplay];

    [playbutton setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    [recoder endRecoder];
    tishiLable.text = [NSString stringWithFormat:@"%.2d:%.2d",recoder.times/60,recoder.times%60];
    stateLabel.text = @"录音结束";
    stateLabel.hidden = NO;
    tishiLable.hidden = NO;
//    stLabel.hidden = NO;
    timeLabel.hidden = YES;
    state = 2;
    [self showAnimation];
    imageView.hidden = YES;

}

- (void)showAnimation{
    
    [UIView animateWithDuration:1 animations:^{
        
        [self insertSubview:fabuButton belowSubview:playbutton];
        [self insertSubview:giveUpbutton belowSubview:playbutton];

    } completion:^(BOOL finished) {

    }];
    
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    state = 0;
    [self buttonAction:nil];
    

}

- (void)hiddens
{
    [self removeFromSuperview];

}


@end
























