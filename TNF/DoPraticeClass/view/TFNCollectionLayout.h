//
//  TFNCollectionLayout.h
//  TNF
//
//  Created by dongliwei on 16/4/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TFNCollectionLayout : UICollectionViewFlowLayout

// 总列数
@property (nonatomic, assign) NSInteger columnCount;
// 数据数组
@property (nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic,strong) UIDynamicAnimator *dynamicAnimator;

@end
