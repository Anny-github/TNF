//
//  BottomView.m
//  TNF
//
//  Created by wss on 16/4/25.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BottomView.h"
#import "LoadImage.h"
#import "WSShapeLayer.h"

@interface BottomView ()
{
    IBOutlet UIImageView *_headImgV;
    IBOutlet UILabel *_nameL;
    
  
    IBOutlet UIButton *timeBtn;
    IBOutlet UIButton *levelBtn;
    
    IBOutlet UIButton *_commentBtn;
    
    
    IBOutlet UIButton *_zanBtn;
    IBOutlet UIImageView *controlBtn;
    
    BOOL isPlaying;
    id observerTime;
}
@property(nonatomic,strong)WSShapeLayer *shapeLayer;

@end

@implementation BottomView

-(void)awakeFromNib{

    
    [controlBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPlay)]];
    

}

-(void)setVoice:(VoicesModel *)voice{

    _voice = voice;

    [LoadImage loadAnnotationImageWithURL:voice.headimgurl imageView:_headImgV finish:^{
        
    }];
    if ([voice.isComment isEqualToString:@"0"]) {
        _commentBtn.hidden = YES;
    }else{
        _commentBtn.hidden = NO;
    }
    _nameL.text = voice.nickname;
    [timeBtn setTitle:voice.time forState:UIControlStateNormal];
        
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_commentBtn setTitle:@"高级批改" forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"voicePigai"] forState:UIControlStateNormal];
    [_commentBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_zanBtn setTitle:@"879赞" forState:UIControlStateNormal];
    [_zanBtn setImage:[UIImage imageNamed:@"zanBtnIcon"] forState:UIControlStateNormal];
    [_zanBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    self.shapeLayer = [[WSShapeLayer alloc]initWithFrame:_headImgV.frame strokeWidth:2 insets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _shapeLayer.progress = 0;
    [self.layer addSublayer:_shapeLayer];

}

#pragma mark --点击图片 控制播放
-(void)controlPlay{
    isPlaying = !isPlaying;
    if (isPlaying) {
        if (self.shapeLayer.progress == 1) {
            self.shapeLayer.progress = 0;
            [self addObserVer];

        }
        [self.player play];
        controlBtn.image = [UIImage imageNamed:@"voicePause"];

        NSLog(@"播放");
        
    }else{
        NSLog(@"暂停");
        [self.player pause];
        controlBtn.image = [UIImage imageNamed:@"playIcon"];

    }
}

-(void)pausePlay{
    isPlaying = NO;
    controlBtn.image = [UIImage imageNamed:@"playIcon"];
    
}
-(void)beginPlay{
    isPlaying = YES;
    self.shapeLayer.progress = 0;
    
    [self addObserVer];
    controlBtn.image = [UIImage imageNamed:@"voicePause"];

    
}

-(void)keepPlay{
    isPlaying = YES;
    
}

-(void)stopPlay{
    [self.player pause];
    observerTime = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.shapeLayer.progress = 0; 
    isPlaying = NO;
    controlBtn.image = [UIImage imageNamed:@"playIcon"];
    
}

-(void)playDidEnd:(NSNotification*)tf{
    
    [self.player pause];
    [self.player removeTimeObserver:observerTime];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.player.currentItem seekToTime:CMTimeMake(0, 1)];
    isPlaying = NO;
    controlBtn.image = [UIImage imageNamed:@"playIcon"];
}

-(void)addObserVer{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    __block typeof(self) weakSelf = self;
    
    observerTime = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue: NULL usingBlock:^(CMTime time) {
        //  获取当前时间
        CMTime currentTime = weakSelf.player.currentItem.currentTime;
        //  转化成秒数
        CGFloat currentPlayTime = (CGFloat)currentTime.value / currentTime.timescale;
        //  总时间
        CMTime totalTime = weakSelf.player.currentItem.duration;
        //  转化成秒
        CGFloat totalMovieDuration = (CGFloat)totalTime.value / totalTime.timescale;
        weakSelf.shapeLayer.progress = currentPlayTime/totalMovieDuration;
        
    }];
    

}

- (IBAction)zanBtnClick:(id)sender {
    
    
}

@end
