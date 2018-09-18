//
//  ActivityCollectionViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityCollectionViewController.h"
#import "ActivityCollectionViewCell.h"
#import "ActivityViewController.h"
#import "ActivityViewPresentationController.h"
#import "ActivityCollectionViewFlowLayout.h"
#import "ActivityInfoRepository.h"



@interface ActivityCollectionViewController ()<UIViewControllerTransitioningDelegate,ActivityInfoRepositoryDelegate>
{

    NSArray * allActivityInfoArray;
    ActivityViewController * activityViewController;
    ActivityViewPresentationController * activityViewPresentationController;
    
}

@end

@implementation ActivityCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self initActivityInfoData];
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    //NavigationBar 設置透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma mark ActivityInfoRepository

- (void)initActivityInfoData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[ActivityInfoRepository sharedInstance]loadAllActivityInfo];
    });
    [ActivityInfoRepository sharedInstance].delegate = self;

}
- (void)loadAllActivityInfoDidFinish:(NSArray *)allActivituInfo{
    NSLog(@"收到 :%@",allActivituInfo[0]);
    dispatch_async(dispatch_get_main_queue(), ^{
        allActivityInfoArray = allActivituInfo;
        [self.collectionView reloadData];
        
    });

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return allActivityInfoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ActivityInfoModel *activityInfo = [allActivityInfoArray objectAtIndex:indexPath.row];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:activityInfo.imageUrl]]];
        activityInfo.image = img;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.activityImage.image =img;
            cell.titleLabel.text = activityInfo.title;
            cell.subtitleLabel.text = activityInfo.subtitle;
        });
    });
    
    // Configure the cell

    

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes* attributes =  [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellFrame = [self.collectionView convertRect:attributes.frame toView:self.view];
    
    activityViewController = [[ActivityViewController alloc]init];
    activityViewController.activityInfoModel = [allActivityInfoArray objectAtIndex:indexPath.row];
    
    activityViewPresentationController = [[ActivityViewPresentationController alloc]initWithPresentedViewController:activityViewController presentingViewController:self];
    activityViewPresentationController.cellFrame = cellFrame;
    activityViewController.transitioningDelegate = activityViewPresentationController;


    [self presentViewController:activityViewController animated:YES completion:nil];
}

//選中Cell (Touch Down)
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityCollectionViewCell *cell = (ActivityCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    //縮小Cell動畫
    [UIView animateWithDuration:0.2
                     animations:^{
                         cell.transform = CGAffineTransformMakeScale(0.96, 0.96);
                     }];

}
//選中Cell取消 (Touch Down)
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCollectionViewCell *cell = (ActivityCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //還原Cell動畫
    [UIView animateWithDuration:0.2
                     animations:^{
                         cell.transform = CGAffineTransformMakeScale(1, 1);
                     }];
}

@end
