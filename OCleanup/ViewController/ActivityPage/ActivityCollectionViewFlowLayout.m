//
//  ActivityCollectionViewFlowLayout.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityCollectionViewFlowLayout.h"

@implementation ActivityCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.headerReferenceSize = CGSizeMake(width, height*0.1);
    self.footerReferenceSize = CGSizeMake(width, height*0.08);
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
