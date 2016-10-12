//
//  PrepareInfoController.m
//  TNF
//
//  Created by wss on 16/4/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "PrepareInfoController.h"

#import "AttributeLabel.h"
@interface PrepareInfoController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *_bgView;
    AttributeLabel *lastFenV;
    AttributeLabel *nextFenV;
    AttributeLabel *leftV;
    AttributeLabel *rightV;
    
    UISlider *lastSlider;
    UISlider *nextSlider;
    UISlider *leftSlider;
    UISlider *rightSlider;
    
    UIButton *tuofuBtn;
    UIButton *yasiBtn;
    
}

@end

@implementation PrepareInfoController

-(PrepareInfoController*)initWithBgViewFrame:(CGRect)frame{
    if (self = [super init]) {
    
        [self initViews:frame];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.text = @"备考信息";
}

#pragma mark --子视图--
-(void)initViews:(CGRect)frame{
    
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _bgView = [[UIView alloc]initWithFrame:frame];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    //
    UILabel *titleL = [WXLabel UIlabelFrame:CGRectMake(0, 0, _bgView.width, 40*ratioHeight) textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:17] labelTag:0];
    titleL.text = @"备考科目";
    titleL.textAlignment = NSTextAlignmentCenter;
//    [_bgView addSubview:titleL];
    
    
    CGFloat margin = 30*ratioWidth;
    tuofuBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*ratioWidth, 20*ratioHeight, (kScreenWidth - margin - 40*ratioWidth*2)/2.0, 35*ratioWidth)];
    [tuofuBtn setTitle:@"托福口语" forState:UIControlStateNormal];
    tuofuBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [tuofuBtn addTarget:self action:@selector(subjectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tuofuBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg_gray"] forState:UIControlStateNormal];
    [tuofuBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg"] forState:UIControlStateSelected];
    [tuofuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [tuofuBtn setTitleColor:UIColorSubTitle forState:UIControlStateNormal];
    tuofuBtn.tag = 1000;
    tuofuBtn.selected = NO;
    [self.view addSubview:tuofuBtn];
    
    yasiBtn = [[UIButton alloc]initWithFrame:CGRectMake(tuofuBtn.right+margin, tuofuBtn.top, tuofuBtn.width, 35*ratioWidth)];
    [yasiBtn setTitle:@"雅思口语" forState:UIControlStateNormal];
    [yasiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [yasiBtn setTitleColor:UIColorSubTitle forState:UIControlStateNormal];
    yasiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yasiBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg_gray"] forState:UIControlStateNormal];
    [yasiBtn setBackgroundImage:[UIImage imageNamed:@"buttonBg"] forState:UIControlStateSelected];
    [yasiBtn addTarget:self action:@selector(subjectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    yasiBtn.selected = NO;
    yasiBtn.tag = 1000;
    [self.view addSubview:yasiBtn];
    if([[UserDefaults valueForKey:subject] integerValue] == 1){
        tuofuBtn.selected = YES;
    }else if([[UserDefaults valueForKey:subject] integerValue] == 2){
        yasiBtn.selected = YES;
    }
    
    //line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, tuofuBtn.bottom + 10*ratioHeight, _bgView.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:line];
    
    
    //考分
    UILabel *lastL = [[UILabel alloc]initWithFrame:CGRectMake(0, line.bottom + 15*ratioHeight, _bgView.width, 15)];
    lastL.text = @"上一次考试分数是?";
    lastL.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:lastL];
    
    lastSlider = [[UISlider alloc] initWithFrame:CGRectMake(10*ratioWidth, lastL.bottom+15*ratioHeight, _bgView.width-20*ratioWidth, 40*ratioHeight)];
    lastSlider.minimumValue = 0;
    [lastSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    lastSlider.minimumTrackTintColor = UIColor1(<#蓝#>);
    lastSlider.maximumTrackTintColor = UIColorTitle;
    lastSlider.tag = 2000;
    [_bgView addSubview:lastSlider];
    
    //分数图片
    
    
    UILabel *nextL = [[UILabel alloc]initWithFrame:CGRectMake(0, lastSlider.bottom, _bgView.width, 15)];
    nextL.text = @"下一次的目标分数是";
    nextL.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:nextL];
    
    nextSlider = [[UISlider alloc] initWithFrame:CGRectMake(10*ratioWidth, nextL.bottom + 15*ratioHeight, _bgView.width-20*ratioWidth, 40*ratioHeight)];
    nextSlider.minimumValue = 0;
    nextSlider.minimumTrackTintColor = UIColor1(<#蓝#>);
    nextSlider.maximumTrackTintColor = UIColorTitle;
    [nextSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    nextSlider.tag = 2001;
    [_bgView addSubview:nextSlider];
     //分数图片
    
    //long
    UILabel *longL = [[UILabel alloc]initWithFrame:CGRectMake(0,nextSlider.bottom, _bgView.width, 15)];
    longL.text = @"一天多长时间练习口语";
    longL.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:longL];
    
    leftSlider = [[UISlider alloc]initWithFrame:CGRectMake(10*ratioWidth, longL.bottom +15*ratioHeight, _bgView.width/2.0-8*ratioWidth, 40*ratioHeight)];
    [leftSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    leftSlider.minimumValue = 0;
    leftSlider.minimumTrackTintColor = UIColor1(<#蓝#>);
    leftSlider.maximumTrackTintColor = UIColorTitle;
    leftSlider.tag = 2002;
    [_bgView addSubview:leftSlider];
    
    rightSlider = [[UISlider alloc]initWithFrame:CGRectMake(_bgView.width/2.0-2*ratioWidth, longL.bottom + 15*ratioHeight, _bgView.width/2.0-10*ratioWidth+2*ratioWidth, 40*ratioHeight)];
    rightSlider.minimumValue = 30;
    rightSlider.minimumTrackTintColor = UIColorTitle;
    rightSlider.maximumTrackTintColor = UIColor1(<#蓝#>);
    [rightSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    rightSlider.tag = 2003;
    [_bgView addSubview:rightSlider];
    
    
    
    //考试时间
    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, leftSlider.bottom, _bgView.width, 15)];
    timelabel.text = @"下次考试时间";
    timelabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:timelabel];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, timelabel.bottom,_bgView.width ,162 *ratioHeight);
    pickerView.delegate = self;
    pickerView.dataSource =self;
    [pickerView selectRow:3 inComponent:0 animated:YES];
    [_bgView addSubview:pickerView];
    
    
    //OK
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-80*ratioWidth, pickerView.bottom -20*ratioHeight, 180*ratioWidth, 44*ratioHeight)];
    [okBtn setTitle:@"OK" forState:UIControlStateNormal];
    okBtn.backgroundColor = UIColor1(<#蓝#>);
    [_bgView addSubview:okBtn];
    
    
    [lastSlider setThumbImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
    [nextSlider setThumbImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];

    [leftSlider setThumbImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
    [rightSlider setThumbImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];

    //分数Label
    lastFenV = [[AttributeLabel alloc]initWithFrame:CGRectMake(0, -15, 80, 30) leftText:@"5" rightText:@"分"];
    
    [lastSlider addSubview:lastFenV];
    
    nextFenV = [[AttributeLabel alloc]initWithFrame:CGRectMake(0, -15, 80, 30) leftText:@"10" rightText:@"分"];
    
    [nextSlider addSubview:nextFenV];
    
    leftV = [[AttributeLabel alloc]initWithFrame:CGRectMake(0, -15, 80, 30) leftText:@"30" rightText:@"分钟"];
    
    [leftSlider addSubview:leftV];
    
    rightV = [[AttributeLabel alloc]initWithFrame:CGRectMake(0, -15, 80, 30) leftText:@"60" rightText:@"分钟"];
    
    [rightSlider addSubview:rightV];
    
    //请求完数据初始化
    lastSlider.value = 0;
    nextSlider.value = 0;
    leftSlider.value = 0;
    rightSlider.value = 30;
    lastSlider.maximumValue = 10;
    lastFenV.centerX = lastSlider.value/lastSlider.maximumValue * lastSlider.width;
    nextSlider.maximumValue = 10;
    nextFenV.centerX = nextSlider.value/nextSlider.maximumValue * nextSlider.width;
    leftSlider.maximumValue = 30;
    leftV.centerX = leftSlider.value/leftSlider.maximumValue * leftSlider.width;
    rightSlider.maximumValue = 60;
    rightV.centerX = (rightSlider.value-rightSlider.minimumValue)/(rightSlider.maximumValue- rightSlider.minimumValue)* rightSlider.width;
}


#pragma mark --点击事件---
//科目点击
-(void)subjectBtnClick:(UIButton*)btn{
    
    if (tuofuBtn.selected && tuofuBtn != btn) {
        tuofuBtn.selected = NO;
        yasiBtn.selected = YES;
    }else if (yasiBtn.selected && yasiBtn != btn){
        
        yasiBtn.selected = NO;
        tuofuBtn.selected = YES;
    }
}

//分数
-(void)sliderValueChange:(UISlider*)slider{
    switch (slider.tag) {
        case 2000: //last
            lastFenV.centerX = slider.value/slider.maximumValue*slider.width;
            lastFenV.leftTitle = [NSString stringWithFormat:@"%.f",slider.value];
        
            break;
        case 2001: //last
            nextFenV.centerX = slider.value/slider.maximumValue*slider.width;
            nextFenV.leftTitle = [NSString stringWithFormat:@"%.f",slider.value];
            break;
        case 2002: //last
            leftV.centerX = slider.value/slider.maximumValue*slider.width;
            leftV.leftTitle = [NSString stringWithFormat:@"%.f",slider.value];
            break;
        case 2003: //last
            rightV.centerX = (slider.value-slider.minimumValue)/(slider.maximumValue-slider.minimumValue)*slider.width;
            rightV.leftTitle = [NSString stringWithFormat:@"%.f",slider.value];
            break;
        
            
        default:
            break;
    }
    
    
}

//时长
-(void)longBtnClick:(UIButton*)btn{
    
}


#pragma mark---UIpickViewdelegate------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    return 40;
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 130*ratioWidth;
}

//每个item显示的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"title";
    
}


//监听选择单元格
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return ratioHeight*50/2;
}



@end
