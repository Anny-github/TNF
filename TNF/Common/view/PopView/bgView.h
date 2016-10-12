//
//  bgView.h
//  TNF
//
//  Created by 李善 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
/**
 *  备考信息设置
  */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol BgViewdelegate<NSObject>

- (void)userExamInfoOK;

@end
@interface bgView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *_whiltBgView;
    UIButton *selebutton;
    NSInteger index; //记录选中的分数的btn的tag
    UIPickerView *_PickView;
    NSDictionary *_parms;//网络请求参数
}
@property(nonatomic,weak)id<BgViewdelegate>BgViewdelegate;
@property(nonatomic,copy)NSString *titleType;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,strong)NSMutableArray *BgAry;
@property(nonatomic,strong)NSArray *timeAry;
@property(nonatomic,strong)NSMutableDictionary*allDic;
- (instancetype)initWithFrame:(CGRect)frame;


@end
