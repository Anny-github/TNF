//
//  SourceCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"

@interface SourceCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *label;
    UILabel *label1;
    
}

@property(nonatomic,retain)FileModel *model;
@end
