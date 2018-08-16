//
//  TicketsCollectionViewFlowLayout.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/15.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketsCollectionViewFlowLayout.h"

//Cell 寬度與螢幕寬度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.75f;

@implementation TicketsCollectionViewFlowLayout


//初始化

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}
#pragma mark -
#pragma mark 動畫
//縮放動畫
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //擴大控制範圍，以免閃退
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //畫面中線
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移動的距離和屏幕寬度的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移動範圍固定到 -π/4 ～ +π/4
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //設置Cell 的縮放 越居中越接近1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

#pragma mark - Cell
#pragma mark  配置方法
//最小縱向
- (CGFloat)minimumLineSpacing {
    return [self cellMargin];
}
//Cell 大小
- (CGSize)itemSize {
    
    return CGSizeMake([self cellWidth],[self cellHeight]);
}

//Cell 寬度
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

//Cell 高度
- (CGFloat)cellHeight {
    return self.collectionView.bounds.size.height * CardHeightScale;
}

//Cell 間隔
- (float)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth])/7;
}

//Cell 左右內縮
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}



#pragma mark -
#pragma mark 其他设定
//是否刷新畫面
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

//???
//防止報錯 先複製attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}


@end
