//
//  GrayStarView.h
//  TNF
//
//  Created by wss on 16/5/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrayStarView : UIView{
    
    //创建星星视图
    //1、金色星星视图.视图全局变量
    UIImageView *_lightGrayView;
    
    UIImageView *_grayview;
    
}


- (instancetype)initWithFrame:(CGRect)frame starmore:(NSInteger)more Grayindex:(NSInteger )Grayindex;

- (void)_createLightGrayStarview:(NSInteger)more Grayindex:(NSInteger)Grayindex;

@property (nonatomic,assign)BOOL islianxi;

@property(nonatomic,assign)float avreage1;

@end
