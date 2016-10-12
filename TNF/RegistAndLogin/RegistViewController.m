//
//  RegistViewController.m
//  TNF
//
//  Created by dongliwei on 16/4/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "RegistViewController.h"
#import "IndexController.h"
#import "LognViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>
{
    UITextField *_phoneTf;
    UITextField *_pwdTf;
    UITextField *_vertifyTf;
    UIButton *_sendVerNumBtn;
    
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor2(<#灰色背景#>);
    self.text = @"注册";
    [self initViews];
    

#warning --测试引导
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"set_01"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

    
}

-(void)registBtnClick{
    IndexController *indexVC = [[IndexController alloc]init];
    [self.navigationController pushViewController:indexVC animated:YES];
}
#pragma mark --子视图--
-(void)initViews{
    
    _phoneTf = [[UITextField alloc]initWithFrame:CGRectMake(15*ratioWidth, 20*ratioHeight, kScreenWidth - 30*ratioWidth, 40*ratioHeight)];
    UILabel *leftV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, _phoneTf.height)];
    leftV.text = @" 手机号: 86+";
    leftV.textColor = [MyColor colorWithHexString:@"0x7e7e80"];
    _phoneTf.leftView = leftV;
    _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTf.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phoneTf];
    
    _pwdTf = [[UITextField alloc]initWithFrame:CGRectMake(15*ratioWidth, _phoneTf.bottom + 10*ratioHeight, kScreenWidth - 30*ratioWidth, 40*ratioHeight)];
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _pwdTf.height)];
    leftView.text = @" 密码:";
    leftView.textColor = [MyColor colorWithHexString:@"0x7e7e80"];
    _pwdTf.leftView = leftView;
    _pwdTf.secureTextEntry = YES;
    _pwdTf.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_pwdTf];
    
    _vertifyTf = [[UITextField alloc]initWithFrame:CGRectMake(15*ratioWidth, _pwdTf.bottom + 10*ratioHeight, kScreenWidth - 30*ratioWidth - 120*ratioWidth, 40*ratioHeight)];
    UILabel *leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, _pwdTf.height)];
    leftView2.text = @" 验证码:";
    _vertifyTf.keyboardType = UIKeyboardTypeNumberPad;
    leftView2.textColor = [MyColor colorWithHexString:@"0x7e7e80"];
    _vertifyTf.leftView = leftView2;
    _vertifyTf.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_vertifyTf];
    
    _sendVerNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(_vertifyTf.right+10*ratioWidth, _vertifyTf.top, kScreenWidth - _vertifyTf.right - 20*ratioWidth, _vertifyTf.height)];
    _sendVerNumBtn.backgroundColor = [MyColor colorWithHexString:@"0x999999"];
    [_sendVerNumBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendVerNumBtn addTarget:self action:@selector(sendVertifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendVerNumBtn];
    _sendVerNumBtn.layer.cornerRadius = 5.0;
    _sendVerNumBtn.layer.masksToBounds = YES;
    
    
    //确认
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(_vertifyTf.left,_vertifyTf.bottom +20*ratioHeight, kScreenWidth-30*ratioWidth , 44*ratioHeight)];
    sureBtn.backgroundColor = UIColor1(<#蓝#>);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5.0;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureRegistBtnClick) forControlEvents:UIControlEventTouchUpInside];
    

    _phoneTf.borderStyle = UITextBorderStyleRoundedRect;
    _pwdTf.borderStyle = UITextBorderStyleRoundedRect;
    _vertifyTf.borderStyle = UITextBorderStyleRoundedRect;

    _phoneTf.returnKeyType = UIReturnKeyDone;
    _pwdTf.returnKeyType = UIReturnKeyDone;
    _vertifyTf.returnKeyType = UIReturnKeyDone;
    _phoneTf.delegate = self;
    _pwdTf.delegate = self;
    _vertifyTf.delegate = self;
    
}


#pragma mark --发送验证码
-(void)sendVertifyBtnClick:(UIButton*)btn{
    
    [self.view endEditing:YES];

}

#pragma mark --确认注册--
-(void)sureRegistBtnClick{
    
    [self.view endEditing:YES];

    [self.navigationController pushViewController:[[LognViewController alloc]init] animated:YES];

    
    if (![TNFPublicTool checkPhone:_phoneTf.text]) {
        return;
    }else if (_pwdTf.text == nil || _pwdTf.text.length < 6){
        [TNFPublicTool HUDWithString:@"密码至少六位"];
        return;
    }
//    else if (<#expression#>) //验证码
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}



@end
