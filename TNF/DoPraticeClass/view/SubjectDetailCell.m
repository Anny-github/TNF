//
//  DetailSubjectCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "SubjectDetailCell.h"
#import "PlayView.h"
#import "FuYuanViewController.h"
#import "CorrectPopView.h"


@interface SubjectDetailCell ()
{
    CustomRecordView *recordView;
    CorrectPopView *popView;
}
@end

@implementation SubjectDetailCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
    
}

- (void)_initViews
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 155 * ratioHeight - 60, kScreenWidth - 20, 60)];
    [button setImage:[UIImage imageNamed:@"jiantou_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(downButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
//    [self.contentView addSubview:button];
    self.fromCellSelcted = YES;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 20 * ratioHeight)];
    titleLabel.textColor = UIColorTitle;
    titleLabel.font = [UIFont systemFontOfSize:18 * ratioHeight];
    [self addSubview:titleLabel];
    
    subTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom+5, kScreenWidth - 80, 20 * ratioHeight)];
    subTitleL.textColor = UIColorSubTitle;
    subTitleL.font = [UIFont systemFontOfSize:14 * ratioHeight];
    subTitleL.text = @"副标题";
    [self addSubview:subTitleL];
    
    //已有练习人
    totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 10 - 120, 10, 120, titleLabel.height)];
    totalLabel.textColor = UIColorSubTitle;
    totalLabel.font = [UIFont systemFontOfSize:14 * ratioHeight];
    totalLabel.textAlignment = NSTextAlignmentRight;
    totalLabel.text = @"3767人已练";
    [self addSubview:totalLabel];

    //已练标签
    myTag = [[UIButton alloc]initWithFrame:CGRectMake(self.width-50*ratioWidth, totalLabel.bottom+5, 40*ratioWidth, 20*ratioHeight)];
    [myTag setBackgroundImage:[UIImage imageNamed:@"is_pratice"] forState:UIControlStateNormal];
    myTag.contentMode = UIViewContentModeCenter;
    [myTag setTitle:@"已练" forState:UIControlStateNormal];
    myTag.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
    myTag.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:myTag];
    
    
    //线
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40 * ratioHeight, kScreenWidth - 40, .5)];
    imageView.backgroundColor = [MyColor colorWithHexString:@"#555555"];
//    [self addSubview:imageView];
    
    question = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom + 30, kScreenWidth - 90 , 13 * ratioHeight)];
    question.textColor = UIColor1(蓝);
    question.font = [UIFont systemFontOfSize:13 * ratioHeight];
    question.textAlignment = NSTextAlignmentLeft;
    question.text = @"Question：";
//    [self addSubview:question];

    answer = [[UILabel alloc] initWithFrame:CGRectMake(10, subTitleL.bottom - 20*ratioHeight, self.width - 20 , 13 * 4 * ratioHeight)];
    answer.textColor = UIColorSubTitle;
    answer.font = [UIFont systemFontOfSize:13 * ratioHeight];
    answer.textAlignment = NSTextAlignmentLeft;
    answer.numberOfLines = 4;
    [self addSubview:answer];
    
    //第几题
    count = [[UILabel alloc] initWithFrame:CGRectMake(10, 155 * ratioHeight - 20, self.width - 20, 15)];
    count.textColor = UIColorSubTitle;
    count.font = [UIFont systemFontOfSize:13 * ratioHeight];
    count.textAlignment = NSTextAlignmentCenter;
    [self addSubview:count];

    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.text = self.model.info.title;
    if ([self.model.count integerValue] == 0) {
        count.text = @"";
    }else{
    count.text = [NSString stringWithFormat:@"<%d/%d>",[self.model.cur intValue],[self.model.count intValue]];
    }
    answer.text = self.model.info.question;
    [answer sizeToFit];
    answer.top = subTitleL.bottom + 15;
    
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    self.contentView.layer.masksToBounds = YES;
    
    
}

- (void)downButtonAction
{
    
    [self animation];
    

}

- (void)animation
{
    [self _initbganimation];
    [UIView animateWithDuration:0.4 animations:^{

        animationView.height = kScreenHeight - 64  - 40 * ratioHeight / 2.0;
        if (self.fromCellSelcted == NO) {
            [self record:nil];

        }
        
    } completion:^(BOOL finished) {

    }];

    
    
    

}

- (void)_initAnimation
{
    //title
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 80, 20 * ratioHeight)];
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:18 * ratioHeight];
    titleL.text = self.model.info.title;
    [animationView addSubview:titleL];
    
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, titleL.bottom+5, kScreenWidth - 80, 20 * ratioHeight)];
    subTitle.textColor = [UIColor blackColor];
    subTitle.font = [UIFont systemFontOfSize:14 * ratioHeight];
    subTitle.text = @"副标题";
    [animationView addSubview:subTitle];
    
    //已有练习人
    UILabel *totalL = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 5 - 120, 20, 120, titleL.height)];
    totalL.textColor = UIColor4(所有的灰色);
    totalL.font = [UIFont systemFontOfSize:14 * ratioHeight];
    totalL.textAlignment = NSTextAlignmentRight;
    totalL.text = @"3767人已练";
    [animationView addSubview:totalL];
    
    //已练标签
    UIButton *myTagLabel = [[UIButton alloc]initWithFrame:CGRectMake(totalL.left + 50, totalL.bottom+5, self.width - totalL.left - 50 - 5, 20*ratioHeight)];
    myTagLabel.backgroundColor = UIColor1(<#蓝#>);
    [myTagLabel setTitle:@"已练" forState:UIControlStateNormal];
    [animationView addSubview:myTagLabel];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, subTitle.bottom, kScreenWidth - 20, kScreenHeight - 64 - 10 - 20 - 65 * ratioHeight / 2.0 - subTitle.bottom)];
    [animationView addSubview:scrollView];
    
    
    int y =  10;
    
    if (self.model.info.reading.length == 0) { //没有Reading Part：

        
    }else{
        
        UILabel *reading = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        reading.textColor = UIColor1(蓝);
        reading.font = [UIFont systemFontOfSize:13 * ratioHeight];
        reading.textAlignment = NSTextAlignmentLeft;
        reading.text = @"Reading part:";
        [scrollView addSubview:reading];
        
        float height;
        
        if (self.model.info.reading.length == 0) {
            height = 0;
        }else{
            height = [self heightForString:self.model.info.reading fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *part = [[UILabel alloc] initWithFrame:CGRectMake(10, reading.bottom + 10, kScreenWidth - 40 , height)];
        part.textColor = UIColor(深色背景);
        part.font = [UIFont systemFontOfSize:13 * ratioHeight];
        part.textAlignment = NSTextAlignmentLeft;
        part.numberOfLines = 0;
        part.text = self.model.info.reading;
        [scrollView addSubview:part];
        scrollView.contentSize = CGSizeMake(0, part.bottom + 20);

        y = part.bottom + 10;

    }

    if (self.model.info.mp3.length == 0) { //没有Listenning part:
        
        
        
    }else{

        UILabel *listen = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        listen.textColor = UIColor1(蓝);
        listen.font = [UIFont systemFontOfSize:13 * ratioHeight];
        listen.textAlignment = NSTextAlignmentLeft;
        listen.text = @"Listenning part:";
        [scrollView addSubview:listen];
        
        
        playView = [[PlayView alloc] initWithFrame:CGRectMake(10, listen.bottom + 10, kScreenWidth / 2.0, 20)];
        playView.backgroundColor = [UIColor yellowColor];
        playView.contentURL = self.model.info.mp3;
        [scrollView addSubview:playView];
        scrollView.contentSize = CGSizeMake(0, playView.bottom + 20);

        y = playView.bottom + 10;
        
    }
    
    if (self.model.info.question.length == 0) {

    }else{

        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  y, kScreenWidth - 90 , 15 * ratioHeight)];
        label1.textColor = UIColor1(蓝);
        label1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.text = @"Question:";
        [scrollView addSubview:label1];
        
        float height1;
        if (self.model.info.question.length == 0) {
            height1 = 0;
        }else{
            height1 = [self heightForString:self.model.info.question fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *question1 = [[UILabel alloc] initWithFrame:CGRectMake(10, label1.bottom + 10, kScreenWidth - 40 , height1)];
        question1.textColor = UIColor(深色背景);
        question1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        question1.textAlignment = NSTextAlignmentLeft;
        question1.numberOfLines = 0;
        question1.text = self.model.info.question;
        [question1 sizeToFit];
        [scrollView addSubview:question1];
        scrollView.contentSize = CGSizeMake(0, question1.bottom + 20);


    }


}

//计算文本高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize size = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.height;
}


- (void)_initbganimation
{
    
    _bganimationView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight)];
    _bganimationView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    animationView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 64 + 10 * ratioHeight, kScreenWidth - 20, 155 * ratioHeight)];
    animationView.showsHorizontalScrollIndicator = NO;
    animationView.showsVerticalScrollIndicator = NO;
    animationView.layer.cornerRadius = 5.0;
    animationView.layer.masksToBounds = YES;
    [self _initAnimation];
    animationView.backgroundColor = [UIColor whiteColor];
    [_bganimationView addSubview:animationView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(animationView.width - 30, animationView.top -5, 40, 40);

//    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal ];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [_bganimationView addSubview:closeButton];
    
    playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight, 65 * ratioHeight, 65 * ratioHeight);
    playbutton.userInteractionEnabled = YES;
    [playbutton setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
    [_bganimationView addSubview:playbutton];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_bganimationView];
    

}

#pragma mark -------录制---------

- (void)record:(UIButton *)sender
{
    playbutton.userInteractionEnabled = NO;
    [playView stop];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    
    [WXDataService requestAFWithURL:Url_getAmountUploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
                playbutton.userInteractionEnabled = YES;
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            int amount = [dic[@"amount"] intValue];
            if (amount < 5) {
                //福币不够
                
                BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"每次作业点评将花费5个福币你目前拥有%d个福币",amount]];
                [self addSubview:view];
                
                
            }else{
                
//                if ([[UserDefaults objectForKey:subject] intValue] == 0) {
//                    
//                    recode = [[RecoderView alloc] initWithTimes:[_model.longs intValue]];
//                    
//                }else{
//                    
//                    recode = [[RecoderView alloc] initWithTimes:[_model.longs intValue]];
//                    
//                }
//                recode.delegate = self;
//                [recode show];
                
                recordView = [[CustomRecordView alloc]initWithTimes:[_model.longs intValue]];
                recordView.delegate = self;
                [recordView show];
                
            }
            playbutton.userInteractionEnabled = YES;
            
        }
        
    } errorBlock:^(NSError *error) {
        playbutton.userInteractionEnabled = YES;
        
        NSLog(@"%@",error);
        
    }];
    

}

#pragma mark -----福币不够了------------
- (void)selecetbtn
{
    
    FuYuanViewController * fuFuYuan = [[FuYuanViewController alloc]init];
    [[self ViewController].navigationController pushViewController:fuFuYuan animated:YES];
    

    
}


#pragma mark --CustomRecordViewDelegate,发布 公开或匿名---
- (void)recordMp3Data:(NSData *)data withTime:(NSString *)time bePublic:(BOOL)isPublic
{
    //请求批改成功，弹出
    CorrectPopView *correctV = [[CorrectPopView alloc]initWithData:@{} requestCorrectSuccess:^{
        LXbgview *bgview = [[LXbgview alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) Title:@"请求批改发布"  Text:@"老师将为你精心点评请注意消息提醒！" delegate:self];
        [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
    }];
    
    [correctV show];
    
    if ([time intValue] < 25) {
        
        //录音时长太短，请重新录制；
        [TNFPublicTool HUDWithString:@"录音时长太短，请重新录制"];
        [recordView hiddens];
        return;
    }
    
    
    [WXDataService postMP3:Url_uploadImgApp params:nil fileData:data finishBlock:^(id result) {
        
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
                [recordView hiddens];
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            [self loadMP3:dic[@"path"] inttime:time];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark --------上传录音-----------
- (void)loadMP3:(NSString *)path inttime:(NSString *)time;
{
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"time":time,@"mp3":path,@"id":self.model.ID,@"lid":self.model.lid,@"type":self.model.type};
    
    [WXDataService requestAFWithURL:Url_uploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
                [recode hiddens];
                return;
                
            }
            
            //上传成功
            
            [recordView hiddens];
            self.publicVoiceSuccess();
            
            //请求批改成功，弹出
            CorrectPopView *correctV = [[CorrectPopView alloc]initWithData:@{} requestCorrectSuccess:^{
                LXbgview *bgview = [[LXbgview alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) Title:@"请求批改发布"  Text:@"老师将为你精心点评请注意消息提醒！" delegate:self];
                [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
            }];
            
            [correctV show];
            popView = correctV;
            
         }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}

#pragma mark ---------LXviewDelegate-------
- (void)clickOK
{
    [popView hide];
    [recordView hiddens];

    // 完成
    [self close];
   
    //题目详情页 在clickOK后动画 减5福币
    [[DetailsubjectController share] clickOK];
      
    
}




#pragma mark ------关闭-------
- (void)close
{
    [playbutton removeFromSuperview];
    playView.player = nil;
    [UIView animateWithDuration:0.4 animations:^{
        
        animationView.height = 155 * ratioHeight;
        
    } completion:^(BOOL finished) {
        
        [_bganimationView removeFromSuperview];
        
    }];
   
    [recordView hiddens];



}


@end
