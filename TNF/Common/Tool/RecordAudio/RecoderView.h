//
//  RecoderView.h
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recoder.h"

#define MAX_RECORD_DURATION 60.0
#define WAVE_UPDATE_FREQUENCY   0.1
#define SILENCE_VOLUME   45.0
#define SOUND_METER_COUNT  6
#define HUD_SIZE  320.0


@protocol RecordViewDelegate <NSObject>

- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time;

@end

@interface RecoderView : UIView<RecordDelegate>
{
    UILabel *stateLabel;
    UILabel *tishiLable;
    UILabel *timeLabel;
    UILabel *stLabel;
    
    UIButton *playbutton;
    UIButton *giveUpbutton;
    UIButton *fabuButton;
    NSTimer *playTimer;
    int playtime;

    Recoder *recoder;
    UIImageView *imageView;
    int state;
    NSTimer *timer;
    int soundMeters[SOUND_METER_COUNT];
    CGRect hudRect; //音量动画rect

}
@property(nonatomic,assign)int times; //录音的总时长
@property(nonatomic,weak)id<RecordViewDelegate> delegate;

- (instancetype)initWithTimes:(int)times;
- (void)show;
- (void)hiddens;


@end
