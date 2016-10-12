//
//  PraticeSpokenController.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
/**
 *  口语答题页
 */

#import "BaseViewController.h"
#import "PraticeSpokenController.h"

@interface PraticeSpokenController : BaseViewController
{
    
    int _pageIndex;
    
    NSString *luyinlong;

}

@property (nonatomic,retain)NSIndexPath *selectedIndexPath;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *lid;
@property (nonatomic,copy)NSString *types;
@property (nonatomic,assign)int index;
@property (nonatomic,retain)NSMutableArray *collectionDatalist;
/**
 *  记录每个题目已经加载的优等声page
 */
@property (nonatomic,retain)NSMutableDictionary *indexdic;
@property (nonatomic,assign)int amount;
//- (void)clickOK;

//+ (PraticeSpokenController *)share;


@end
