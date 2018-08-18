//
//  ActivityCollectionViewFlowLayout.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityCollectionViewFlowLayout.h"

@implementation ActivityCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.headerReferenceSize = CGSizeMake(50, 50);
    self.footerReferenceSize = CGSizeMake(10, 10);
}

- (CGFloat)minimumLineSpacing {
    return 50;
}
- (CGFloat)minimumInteritemSpacing {
    return 20;
}
//Cell 大小
- (CGSize)itemSize {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return CGSizeMake(width * 0.9, height * 0.45);
}




@end
