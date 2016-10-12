//
//  DetailsubjectController.h
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.

// 题目练习详情，collectionView轮播题目，tableView展示 优等声、解题思路、相关素材

#import "BaseViewController.h"
#import "LXSgement.h"
#import "RecoderView.h"
#import "LXbgview.h"
#import "BgView4.h"

@interface DetailsubjectController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,LXDelegate,UIScrollViewDelegate,RecordViewDelegate,LXbgviewDelegate,BgView4delegate>
{
    UITableView *_tableView;
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *layout;
    double _edge;
    UIButton *playbutton;
    UIButton *playbutton1;
    int type;

    int _pageIndex;
    BOOL _isdownLoad;
    LXSgement *sgemet;
    RecoderView *recodeView;
    
    NSString *luyinlong;


}
@property (nonatomic,retain)NSIndexPath *selectedIndexPath;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *lid;
@property (nonatomic,copy)NSString *types;
@property (nonatomic,assign)int index;
@property (nonatomic,retain)NSMutableArray *collectionDatalist;
@property (nonatomic,retain)NSMutableArray *datalist;
@property (nonatomic,retain)NSMutableDictionary *indexdic;
@property (nonatomic,assign)int amount;
- (void)clickOK;

+ (DetailsubjectController *)share;

@end
