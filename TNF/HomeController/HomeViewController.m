//
//  HomeViewController.m
//  TNF
//
//  Created by dongliwei on 16/4/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "HomeViewController.h"
#import "TFPicScrollView.h"
#import "UIImage+BoxBlur.h"
#import "RedPointButton.h"

#import "NotificationController.h"
#import "DataAnalysisController.h"
#import "PrepareInfoController.h"
#import "TrainingrecordViewController.h"
#import "IntelligentAlertView.h"
#import "TPOSiftController.h"

#import "WXLabel.h"

#import "TFYSmodel.h"
//测试
#import "PraticeSpokenController.h"
#import "RegistViewController.h"
#import "MyCourseController.h"

#define HomeCellUser @"homeCell"
@interface HomeViewController ()
{
    
    __weak IBOutlet UITableView *_tableView;
    
    TFPicScrollView *_bannerView;
    
    UILabel *_yuandian; //练习数原点
    UILabel *_daybutton;  //天数btn
    UILabel *_prompt; //距离

    UIImageView *_BgImgView; //headerV图片
    UIView *_tableHeaderV;
    TFYSmodel *_TFYFmodel;
    NSArray *_dataArray;
    UIView *_headerBottomV;
    
    
}

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.text = @"首页";
    self.view.backgroundColor = [MyColor colorWithHexString:@"0x000000"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HomeCellUser];
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"notification_red"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self Mydataservice];
    
#warning --测试我的课程
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"alert_success_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

}

#pragma mark -- 消息通知
-(void)noticeBtnClick{
    [self.navigationController pushViewController:[[NotificationController alloc]init] animated:YES];
}

#pragma mark -- 网络请求---------
- (void)Mydataservice{
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    [WXDataService requestAFWithURL:Url_getStudentHome params:params httpMethod:@"POST" finishBlock:^(id result) {
        if([result[@"states"] intValue]== 0){
            NSLog(@"ggggg%@",result);
            NSDictionary *re = result[@"result"];
            _TFYFmodel = [[TFYSmodel alloc]initWithDataDic:re];
            _TFYFmodel.apptime =re[@"app_ex_time"];
            _TFYFmodel.subjectCN = re[@"subjectCN"];
            _TFYFmodel.recommendList = re[@"recommendList"];
            _TFYFmodel.com_list = re[@"com_list"];
            _TFYFmodel.sub = re[@"subject"];
            _TFYFmodel.appscore = re[@"app_t_score"];
            _TFYFmodel.mp4Url = re[@"mp4Url"];
            NSInteger sub = [re[@"subject"] integerValue];
            if (sub == 1) {
                _TFYFmodel.Grayindex = 4;
            }else if(sub ==2){
                _TFYFmodel.Grayindex =9;
            }
            
            
            _dataArray = @[@""];
            [self cereateHeaderView];
#warning  --关闭签到询问
            //            [self SignFubi];
            
            //是否有联习
            if([re[@"isNewRecord"] integerValue] == 0 )
            {
                _yuandian.hidden = YES;
                
            } else {
                _yuandian.hidden = NO;
            }
            
            [_tableView reloadData];
        }
        if([result[@"states"] intValue]== 1){
            [TNFPublicTool HUDWithString:result[@"msg"]];
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --创建headerView
-(void)cereateHeaderView{
    
    
    _tableHeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    //banner
    _bannerView = [TFPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 40*ratioHeight) WithImageUrls:@[@"add",@"close_01"]];
    _bannerView.backgroundColor = [UIColor redColor];
    [_tableHeaderV addSubview:_bannerView];
    
    
    //备考
    _BgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _bannerView.bottom, kScreenWidth, 200*ratioHeight)];
    _BgImgView.userInteractionEnabled = YES;
    [_tableHeaderV addSubview:_BgImgView];
    [_BgImgView sd_setImageWithURL:[NSURL URLWithString:_TFYFmodel.backgroupImg] placeholderImage:nil];

    

    
    _headerBottomV = [[UIView alloc]initWithFrame:_BgImgView.frame];
    _headerBottomV.backgroundColor = [UIColor clearColor];
    [_tableHeaderV addSubview:_headerBottomV];
    _tableHeaderV.height = _bannerView.height + _BgImgView.height;
    
    //练习信息
    _daybutton = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*ratioHeight, 200, 50*ratioHeight)];
    _daybutton.backgroundColor = [UIColor clearColor];
    _daybutton.textColor = UIColor9(<#白色#>);
    _daybutton.userInteractionEnabled = YES;
    _daybutton.textAlignment = NSTextAlignmentCenter;
    [_daybutton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dayBtnClick)]];
    NSString *text = [NSString stringWithFormat:@"%@天",_TFYFmodel.apptime];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:45*ratioHeight]} range:NSMakeRange(0, text.length-1)];
    _daybutton.attributedText = attributeStr;
    [_headerBottomV addSubview:_daybutton];
    _daybutton.centerX = _headerBottomV.width/2.0;
    
    _prompt = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*100/2, _daybutton.bottom, kScreenWidth-ratioWidth*200/2, ratioHeight*40/2) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:32];
    
    _prompt.textAlignment = NSTextAlignmentCenter;
    _prompt.text = _TFYFmodel.app_ex_timeCN;

    [_headerBottomV addSubview:_prompt];
    
    
    //down
    UIView *effectVTop = [[UIView alloc]initWithFrame:CGRectMake(0, _headerBottomV.height - ratioHeight*75, kScreenWidth, ratioHeight*75)];
    effectVTop.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [_headerBottomV addSubview:effectVTop];
    
    //练习
    
    CGFloat Width_W = 60 * ratioWidth / 2.0;
    CGFloat buWidth = (kScreenWidth- Width_W * 4)/3.0;
    
    NSArray *Labelarray = @[@"练习录音",@"练习天数",@"预测分数"];
    NSArray *countArr = @[_TFYFmodel.recordCount,_TFYFmodel.scoreP,_TFYFmodel.appscore];
    for (int i = 0; i< Labelarray.count; i++) {
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake((buWidth+Width_W)*i+Width_W,10*ratioHeight, buWidth, ratioHeight*70/2)];
        button.titleLabel.font = [UIFont systemFontOfSize:40/2*ratioHeight];
        [button setTitle:countArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [effectVTop addSubview:button];
        button.tag = 100+i;
        
        //圆点
        if (i == 0 ) {
            _yuandian = [[UILabel alloc]init];
            _yuandian.frame = CGRectMake(button.right - buWidth / 2.0 + 15  , button.top, ratioHeight*20/2,ratioHeight*20/2);
            _yuandian.backgroundColor =[UIColor redColor];
            [_yuandian.layer setMasksToBounds:YES];
            [_yuandian.layer setCornerRadius:ratioHeight*20/4];
            [effectVTop addSubview:_yuandian];
        }
        
        
        
        NSString *labelName = Labelarray[i];
        UILabel *ModelLabel= [WXLabel UIlabelFrame:CGRectMake((buWidth+Width_W)*i+Width_W, button.bottom, buWidth, ratioHeight*30/2) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:ratioHeight*26/2] labelTag:33];
        ModelLabel.textAlignment = NSTextAlignmentCenter;
        ModelLabel.text = labelName;
        [effectVTop addSubview:ModelLabel];
        ModelLabel.tag = i+130;
    }

    _tableView.tableHeaderView = _tableHeaderV;
    
    [self.view setNeedsLayout];
    
}


#pragma mark --dayBtnClick，进入我的备考信息--
-(void)dayBtnClick{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController pushViewController:[[PrepareInfoController alloc]initWithBgViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)] animated:YES];
}

#pragma mark --三个按钮---
-(void)buttonAction:(UIButton*)btn{
    switch (btn.tag) {
            
        case 100:
            //进入我的练习
            [self.navigationController pushViewController:[[TrainingrecordViewController alloc]init] animated:YES];
            
            break;
        case 101:
            //练习数
            break;
        case 102:
            //预测分
            [self.navigationController pushViewController:[[DataAnalysisController alloc]init] animated:YES];
            break;
            
        default:
            break;
    }
}
#pragma mark --UITableViewDelegate----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellUser forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10*ratioWidth, 0, cell.contentView.width-20*ratioWidth, cell.contentView.height - 5)];
    imgV.image = [UIImage imageNamed:@"Default"];
    [cell.contentView addSubview:imgV];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    switch (indexPath.row) {
        case 0: //智能快速练习
        {
            //进入快速智能练习
            if(![[UserDefaults valueForKey:IntelligentTestAlert] integerValue]){
                [IntelligentAlertView show];
                
            }
            //
            PraticeSpokenController *detailVC = [[PraticeSpokenController alloc]init];
            detailVC.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            detailVC.ID = @"1339";
            detailVC.lid = @"107";
            detailVC.types = @"1";
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 1:
            //机经预测首页筛选
            [self.navigationController pushViewController:[[TPOSiftController alloc]init] animated:YES];
            break;
            
        default:
            break;
    }
    
    
}

#warning --测试
-(void)registBtnClick{
    
    [self.navigationController pushViewController:[[MyCourseController alloc]init] animated:YES];
}

@end
