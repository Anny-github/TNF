//
//  VoiceCell.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceModel.h" //声音model

@interface VoiceCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *headImgV;
    
}

@property(nonatomic,strong)VoicesModel *model;

@end
