//
//  DetailSubjectCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
#import "PlayView.h"
#import "RecoderView.h"
#import "BgView4.h"
#import "LXbgview.h"
#import "DetailsubjectController.h"
#import "CustomRecordView.h"


@interface SubjectDetailCell : UICollectionViewCell<BgView4delegate,LXbgviewDelegate,CustomRecordViewDelegate>
{
    UIView *_bganimationView;
    UIScrollView *animationView;
    UIView *_maskView;
    UIButton *playbutton;
    UIButton *playbutton1;
    PlayView *playView;
    UIScrollView *scrollView;

    UILabel *titleLabel;
    UILabel *subTitleL;
    UILabel *count;
    UILabel *question;
    UILabel *answer;
    UILabel *totalLabel;
    UIButton *myTag;
    
    RecoderView *recode;
}

@property(nonatomic,assign)BOOL fromCellSelcted;
@property (nonatomic,retain)SubjectModel *model;
@property(nonatomic,copy)void(^publicVoiceSuccess)();
- (void)downButtonAction;

@end
