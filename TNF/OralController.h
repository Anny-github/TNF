//
//  OralController.h
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.

//口语练习首页

#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface OralController : BaseViewController
{
    UIScrollView *scrollView;


}
@property(nonatomic,retain)NSMutableArray *banners;
@property(nonatomic,retain)NSMutableArray *listarray;

/**
 口语练习页 “我的练习点击”
 */
- (void)lianxi:(UIButton *)button;
-(void)examInfoChange;

@end
