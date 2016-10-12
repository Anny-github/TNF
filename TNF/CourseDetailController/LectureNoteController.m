//
//  LectureNoteController.m
//  TNF
//
//  Created by wss on 16/5/10.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "LectureNoteController.h"

@interface LectureNoteController ()

@end

@implementation LectureNoteController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

#pragma mark --initViews--
-(void)initViews{
    self.text = @"讲义页面";
    UIButton *_shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_shareBtn];
    [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)shareBtnClick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
