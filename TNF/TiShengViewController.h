//
//  TiShengViewController.h
//  TNF
//
//  Created by 李江 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//提升课程，首页进入
/**
 *  1、录播课  2、直播课(进入详情是webView)
    2、录播课详情：PromotioncourseViewController
 */

#import "BaseViewController.h"

@interface TiShengViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UICollectionViewFlowLayout *layout;
    UICollectionView *_collectionView;
    UITableView *_tableView;

}
@end
