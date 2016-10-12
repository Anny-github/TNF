//
//  TPOSiftController.m
//  TNF
//
//  Created by wss on 16/5/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TPOSiftController.h"
#import "TPOHeaderViewTask.h"

#define CellUser @"TPOCell"
#define HeadUser @"TPOHeader"
@interface TPOSiftController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *layout;
    TPOHeaderViewTask *_headerView0;
    TPOHeaderViewTask *_headerView1;

    NSIndexPath *selectedIndexPath;
}


@end

@implementation TPOSiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initViews];

}
- (void)_initViews
{
    self.text = @"TPO练习";
    self.view.backgroundColor = [MyColor colorWithHexString:@"0xededed"];
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-1*ratioWidth)/ 2.0,40 * ratioHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth , 40 * ratioHeight);
    layout.minimumLineSpacing = 1*ratioWidth;
    layout.minimumInteritemSpacing = 1*ratioHeight;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    
    [_collectionView registerClass:[TPOHeaderViewTask class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadUser];

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellUser];
    [self.view addSubview:_collectionView];
    
}


#pragma mark - UICollectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellUser forIndexPath:indexPath];
    
    UILabel *label = [cell.contentView viewWithTag:1000];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(10*ratioWidth, 0, 150, cell.height)];
        label.tag = 1000;
        label.textColor = [MyColor colorWithHexString:@"0x3b3b3b"];
        [cell.contentView addSubview:label];
    }
    if (indexPath.section == 0) {
        label.text = @"Task";

    }else{
        label.text = @"TPO 10";

    }
    
    //
    UIButton *selectBtn = [cell.contentView viewWithTag:1001];
    if (!selectBtn) {
        selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.width-40*ratioWidth, 0, 30*ratioWidth, cell.height)];
        [selectBtn setImage:[UIImage imageNamed:@"selectedBg_blue"] forState:UIControlStateNormal];
        selectBtn.tag = 1001;
        [cell.contentView addSubview:selectBtn];
        selectBtn.hidden = YES;

    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取消之前选中的
    if (selectedIndexPath && selectedIndexPath!=indexPath) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:selectedIndexPath];
        UIButton *btn = [cell.contentView viewWithTag:1001];
        btn.hidden = YES;
    }
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIButton *btn = [cell.contentView viewWithTag:1001];
    if (btn.hidden == YES) {
        btn.hidden = NO;
        selectedIndexPath = indexPath;
    }
    
    //
    
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        view.backgroundColor = [MyColor colorWithHexString:@"0xededed"];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            _headerView0 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadUser forIndexPath:indexPath];
            _headerView0.title = @"按Task分";
            _headerView0.image = [UIImage imageNamed:@"arrow_up"];
            _headerView0.selectedImg = [UIImage imageNamed:@"arrow_down"];
            _headerView0.btnSelected = ^(BOOL isSelected){
                
            };
            reusableview = _headerView0;

        }else{
            _headerView1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadUser forIndexPath:indexPath];
            _headerView1.title = @"按TPO套数";
            _headerView1.image = [UIImage imageNamed:@"sort_down"];
            _headerView1.selectedImg = [UIImage imageNamed:@"sort_up"];
            _headerView1.btnSelected = ^(BOOL isSelected){
                
            };
            reusableview = _headerView1;
        }
        
      
        
    }
    return reusableview;
    
}





@end
