//
//  ClassMachineController.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "ClassMachineController.h"
#import "MachineCell.h"
#import "ClassHeaderView.h"

#define CellUser @"machineCell"
#define HeaderUser @"headerUser"
@interface ClassMachineController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *layout;
    ClassHeaderView *_headerView;
}
@end

@implementation ClassMachineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initViews];
}

- (void)_initViews
{
    self.text = @"托您的福机经";
    self.view.backgroundColor = [MyColor colorWithHexString:@"f3f3f3"];
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth/ 2.0,140 * ratioHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth , 55 * ratioHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    
    [_collectionView registerClass:[ClassHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderUser ];
    [_collectionView registerNib:[UINib nibWithNibName:@"MachineCell" bundle:nil] forCellWithReuseIdentifier:CellUser];
    [self.view addSubview:_collectionView];
    
//    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
//    [_collectionView.header beginRefreshing];
//    
}


#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    MachineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellUser forIndexPath:indexPath];
    if (indexPath.row %2 == 0) {
        cell.type = 0;
    }else{
        cell.type = 1;
    }
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderUser forIndexPath:indexPath];
        _headerView.backgroundColor = [MyColor colorWithHexString:@"dcdcdc"];
        _headerView.text1 = @"共10类266道题";
        _headerView.text2 = @"已练习66道";
        reusableview = _headerView;
        
    }
    reusableview.frame = CGRectMake(0, 0, kScreenWidth, 55*ratioHeight);
    return reusableview;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
