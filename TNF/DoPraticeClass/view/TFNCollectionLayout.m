//
//  TFNCollectionLayout.m
//  TNF
//
//  Created by dongliwei on 16/4/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TFNCollectionLayout.h"

@interface TFNCollectionLayout ()
{
    CGFloat columnHeight[3];
    
}
// 所有item的属性的数组
@property (nonatomic, strong) NSArray *layoutAttributesArray;

@end

@implementation TFNCollectionLayout

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
/**
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize.....
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
- (void)prepareLayout {
    // 根据列数 计算item的宽度 宽度是一样的
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat marginX = self.minimumInteritemSpacing;
    CGFloat itemWidth = (contentWidth - marginX * (self.columnCount - 1)) / self.columnCount;
    //初始化dynimic对象
    if (!self.dynamicAnimator) {
        
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
    }
    // 计算布局属性
    [self computeAttributesWithItemWidth:itemWidth];
    
    /*if (self.dynamicAnimator.behaviors.count == 0)
     {
     
     [self.layoutAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
     //            obj.transform = CGAffineTransformMakeRotation(0.5);
     
     if (!CGRectEqualToRect(CGRectZero, [obj bounds]))
     {
     UIAttachmentBehavior *attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:obj attachedToAnchor:[obj center]];
     
     attachBehavior.length = .0f;
     attachBehavior.damping = .8f;
     attachBehavior.frequency = 0.6f;
     //9.0
     //                attachBehavior.attachmentRange = UIFloatRangeMake(1, 3);
     //
     //                UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[obj]];
     //                gravityBehaviour.gravityDirection = CGVectorMake(0, -10);
     
     UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[obj]];
     
     //                [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
     //
     [collisionBehavior setCollisionMode:UICollisionBehaviorModeBoundaries];
     
     //                UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[obj]];
     
     //                [itemBehavior setElasticity:0.6];
     [self.dynamicAnimator addBehavior:attachBehavior];
     //                [self.dynamicAnimator addBehavior:gravityBehaviour];
     [self.dynamicAnimator addBehavior:collisionBehavior];
     //                [self.dynamicAnimator addBehavior:itemBehavior];
     }
     
     
     }];
     }*/
    
}


/**
 *  根据itemWidth计算布局属性
 */
- (void)computeAttributesWithItemWidth:(CGFloat)itemWidth {
    
    
    // 定义一个列高数组 记录每一列的总高度
    // 定义一个记录每一列的总item个数的数组
    NSInteger columnItemCount[self.columnCount];
    
    // 初始化
    for (int i = 0; i < self.columnCount; i++) {
        columnHeight[i] = self.sectionInset.top;
        columnItemCount[i] = 0;
    }
    
    // 遍历 goodsList 数组计算相关的属性
    NSInteger index = 0;
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.dataList.count];
    CGFloat itemW = itemWidth;
  
    for (int i=0; i<self.dataList.count; i++) {
    
        //宽如果不等 最宽是itemWidth
        int random = arc4random_uniform(2);
        CGFloat beishu;
        switch (random) { //根据真实数据设置缩放倍数
            case 1:
                beishu = 1.0;
                break;
            case 2:
                beishu = 1.2;
                break;
            default:
                beishu = 1.1;
                break;
        }
        itemW = itemWidth * beishu;
        // 建立布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        // 找出最短列号
        NSInteger column = [self shortestColumn:columnHeight];
        // 数据追加在最短列
        columnItemCount[column]++;
        // X值
        CGFloat itemX = (itemW + self.minimumInteritemSpacing) * column + self.sectionInset.left;
        
        if (beishu == 0.7) {
            itemX = (itemW + self.minimumInteritemSpacing) * column + self.sectionInset.left + 20;
            
        }
        // Y值
        CGFloat itemY = columnHeight[column];
        // 等比例缩放 计算item的高度
        //        CGFloat itemH = good.h * itemWidth / good.w;
        CGFloat itemH = itemW; //等宽高
        // 设置frame
        attributes.frame = CGRectMake(itemX, itemY, itemW, itemH);
        [attributesArray addObject:attributes];
        
        // 累加列高
        columnHeight[column] += itemH + self.minimumLineSpacing;
        
        index++;
    }
    
    // 找出最高列列号
    NSInteger column = [self highestColumn:columnHeight];
    
    // 根据最高列设置itemSize 使用总高度的平均值
    CGFloat itemH = (columnHeight[column] - self.minimumLineSpacing * columnItemCount[column]) / columnItemCount[column];
    self.itemSize = CGSizeMake(itemW, itemH);
    
    // 添加页脚属性
//    NSIndexPath *footerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerIndexPath];
//    footerAttr.frame = CGRectMake(0, columnHeight[column], self.collectionView.bounds.size.width, 50);
//    [attributesArray addObject:footerAttr];
    
    // 给属性数组设置数值
    self.layoutAttributesArray = attributesArray.copy;
}

/**
 *  找出columnHeight数组中最短列号 追加数据的时候追加在最短列中
 */
- (NSInteger)shortestColumn:(CGFloat *)columnHei {
    
    CGFloat max = CGFLOAT_MAX;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHei[i] < max) {
            max = columnHei[i];
            column = i;
        }
    }
    return column;
}


/**
 *  找出columnHeight数组中最高列号
 */
- (NSInteger)highestColumn:(CGFloat *)columnHei {
    CGFloat min = 0;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHei[i] > min) {
            min = columnHei[i];
            column = i;
        }
    }
    return column;
}


/**
 *  跟踪效果：当到达要显示的区域时 会计算所有显示item的属性
 *           一旦计算完成 所有的属性会被缓存 不会再次计算
 *  @return 返回布局属性(UICollectionViewLayoutAttributes)数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
    
    
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds

{
    
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(CGSize)collectionViewContentSize{
    CGFloat width = [[[UIApplication sharedApplication]keyWindow] bounds].size.width;
    
    return CGSizeMake(width,columnHeight[[self highestColumn:columnHeight]]);
}


@end
