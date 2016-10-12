//
//  MyController.m
//  TNF
//
//  Created by wss on 16/4/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "MyController.h"
#import "MyAccountController.h"
#import "MymedalController.h"
#import "PersonalinformationViewController.h"
#import "FuYuanViewController.h"
#import "ProformainformationViewController.h"
#import "TrainingrecordViewController.h"
#import "MyCourseController.h"
#import "AgreementandtermsViewController.h"
#import "FeedbackViewController.h"
#import "JoinUsViewController.h"
#import "DayTimeAlertController.h"
#import "SetupModel.h"
#import "VoiceCollectController.h"
#import "ServiceController.h"
#import "PrepareInforMation/PrepareInfoController.h"
#import "MyCell.h"
#import "LoadImage.h"

#define CellUser @"MyCell"
@interface MyController ()
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *_tableHeaderV;
    
    __weak IBOutlet UIImageView *_headerImgV;
    __weak IBOutlet UILabel *_nikeNameLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    
    NSArray *_menuArr;
    NSArray *_imgArr;
    NSArray *_controllerArr;
    
    UILabel *_leftMoneyL;
    UILabel *_praticeCount;
    UILabel *_noAlertOn;
    UILabel *_cacheLabel;
    
    
}
@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}

-(void)initViews{
    
    _menuArr = @[@{@"账户":@[@"账户余额",@"勋章墙"]},@{@"练习":@[@"练习历史",@"录音收藏",@"备考信息",@"每日练习提醒"]},@{@"课程":@[@"直播课提醒",@"我的课程"]},@{@"设置":@[@"在线客服",@"清除缓存"]}];
    _imgArr = @[@[[UIImage imageNamed:@"me_leftMoney"],[UIImage imageNamed:@"me_medalIcon"]],@[[UIImage imageNamed:@"me_practiceHistory"],[UIImage imageNamed:@"me_collectIcon"],[UIImage imageNamed:@"me_practiceHistory"],[UIImage imageNamed:@"me_clock"]],@[[UIImage imageNamed:@"me_onLiveAlert"],[UIImage imageNamed:@"me"]],@[[UIImage imageNamed:@"me_consultIcon"],[UIImage imageNamed:@"me_clearIcon"]]];
    _controllerArr = @[[[MyAccountController alloc]init],[[MymedalController alloc]init],[[TrainingrecordViewController alloc]init],[[VoiceCollectController alloc]init],[[PrepareInfoController alloc]initWithBgViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)],[[DayTimeAlertController alloc]init],[[MyCourseController alloc]init],[[ServiceController alloc]init]];
    
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    [_tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:CellUser];
    
    //tableFooterView
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100*ratioHeight)];
    footV.backgroundColor = UIColor2(<#灰色背景#>);
    UIButton *existBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10*ratioHeight, kScreenWidth, 50*ratioHeight)];
    [existBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [existBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    existBtn.centerX = footV.width/2.0;
    existBtn.backgroundColor = UIColor1(<#蓝#>);
    [existBtn addTarget:self action:@selector(existLogin) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:existBtn];
    _tableView.tableFooterView = footV;
    _tableView.backgroundColor = UIColor2(<#灰色背景#>);
    _headerImgV.layer.cornerRadius = _headerImgV.width/2.0;
    _headerImgV.layer.masksToBounds = YES;
    
    _tableView.tableHeaderView = _tableHeaderV;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableHeaderV.backgroundColor = UIColor2(<#灰色背景#>);
    //个人信息
    [_tableView.tableHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personInfoEnter)]];
    
    [LoadImage loadAnnotationImageWithURL:[UserDefaults valueForKey:IcanUrl] imageView:_headerImgV finish:^{
        
    }];
    
}

-(void)personInfoEnter{
    PersonalinformationViewController *personVC = [[PersonalinformationViewController alloc]init];
    [self.navigationController pushViewController:personVC animated:YES];
}

-(void)existLogin{
    
    [UserDefaults setBool:NO forKey:ISLogin];
    [UserDefaults setObject:@"" forKey:Userid];
    [UserDefaults setObject:@"" forKey:IcanUrl];
    [UserDefaults setObject:@"" forKey:Nickname];
    [UserDefaults setObject:@"" forKey:subject];
    [UserDefaults setObject:@"" forKey:Useramount];
    [UserDefaults setObject:@"" forKey:app_ex_time];
    [UserDefaults setObject:@""  forKey:app_t_score];
    [UserDefaults setObject:@""  forKey:Username];
    [UserDefaults setObject:@""  forKey:mobile1];
    [UserDefaults setObject:@""  forKey:weixin1];
    [UserDefaults synchronize];
    //    [MBProgressHUD showSuccess:@"退出登录" toView:self.view];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_LoginOut object:nil];
    

}

#pragma mark --TableViewDelegate---
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*ratioHeight;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _menuArr.count;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSDictionary *dic = _menuArr[sectionIndex];
    NSArray *arr =  dic.allValues.firstObject;
    return arr.count;
}



//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35*ratioHeight)];
    label.backgroundColor = UIColor2(<#灰色背景#>);
    
    NSDictionary *dic = _menuArr[section];
    label.text = [NSString stringWithFormat:@"   %@",dic.allKeys.firstObject];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 35*ratioHeight;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellUser forIndexPath:indexPath];
    
    NSDictionary *dic = _menuArr[indexPath.section];
    NSArray *arr =  dic.allValues.firstObject;
    NSArray *imgarr = _imgArr[indexPath.section];
    cell.headImg.image = imgarr[indexPath.row];
    cell.titleLabel.text = arr[indexPath.row];
    cell.accessoryTitle.hidden = YES;
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell.accessoryTitle.hidden = NO;
                break;
            default:
                break;
        }
        
    }else  if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.accessoryTitle.hidden = NO;
                cell.accessoryTitle.text = @"20";
                break;
            case 2:
                cell.accessoryTitle.hidden = NO;
                cell.accessoryTitle.text = @"托福";
                break;
            case 3:
                cell.accessoryTitle.hidden = NO;
                cell.accessoryTitle.text = @"未开启";
                break;
            default:
                break;
        }

    }else  if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UISwitch *switchB = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-65*ratioWidth,cell.height/2.0 - 31/2.0, 0,0)];
            [cell addSubview:switchB];
            cell.rightImg.hidden = YES;

        }
    }
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, cell.contentView.height - 0.5, kScreenWidth, .5)];
    lineview.backgroundColor = UIColorFromRGB(0xcccccc);
    [cell.contentView addSubview:lineview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:_controllerArr[0] animated:YES];
            }else{
                [self.navigationController pushViewController:_controllerArr[1] animated:YES];
            }
        }
        break;
        case 1:{
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:_controllerArr[2] animated:YES];
            }else if (indexPath.row == 1){
                [self.navigationController pushViewController:_controllerArr[3] animated:YES];
            }else if (indexPath.row == 2){
                [self.navigationController pushViewController:_controllerArr[4] animated:YES];
            }else if (indexPath.row == 3){
                [self.navigationController pushViewController:_controllerArr[5] animated:YES];
            }
         }
            break;
        case 2:{
            if (indexPath.row == 1) {
                [self.navigationController pushViewController:_controllerArr[6] animated:YES];
            }
        }
            break;
        case 3:{
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:_controllerArr[7] animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
    
}


@end
