//
//  PromotioncourseViewController.h
//  TNF
//
//  Created by 李立 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
/**
 *  视频课程详情
    课程介绍、练习题、
 *
 
 **/
#import "BaseViewController.h"

@interface PromotioncourseViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *promotionTableView;
@property(nonatomic,strong)TabBarItem *tab;
@property(nonatomic,strong)NSString *Videoid;
@property(nonatomic,strong)NSString *teacherID;
@property(nonatomic,strong)NSString *moenyCost;
@end
