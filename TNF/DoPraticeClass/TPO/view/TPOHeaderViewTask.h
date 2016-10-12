//
//  TPOHeaderViewTask.h
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TPOHeaderViewTask : UICollectionReusableView

@property(nonatomic,copy)void(^btnSelected)(BOOL isSelected);
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIImage *selectedImg;

@end
