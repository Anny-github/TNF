//
//  CustomRecordView.h
//  TNF
//
//  Created by wss on 16/5/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomRecordViewDelegate <NSObject>

- (void)recordMp3Data:(NSData *)data withTime:(NSString *)time bePublic:(BOOL)isPublic;


@end


@interface CustomRecordView : UIView<RecordDelegate>

@property(nonatomic,assign)int times; //录音的总时长
@property(nonatomic,weak)id<CustomRecordViewDelegate> delegate;

- (instancetype)initWithTimes:(int)times;
- (void)show;
- (void)hiddens;
@end
