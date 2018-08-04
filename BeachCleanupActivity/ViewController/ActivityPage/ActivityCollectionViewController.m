//
//  ActivityCollectionViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityCollectionViewController.h"
#import "ActivityCollectionViewCell.h"
#import "ActivityViewController.h"
#import "ActivityInfoData.h"
#import "PresentCellTransitionController.h"

@interface ActivityCollectionViewController ()<UIViewControllerTransitioningDelegate>
{
    PresentCellTransitionController *  presentCellTransitionController;
    ActivityInfoData * activityInfoData;
    NSMutableArray * allActivityInfoArray;
    
}

@end

@implementation ActivityCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    self = [super init];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(width * 0.9, height * 0.45);
    
    layout.headerReferenceSize = CGSizeMake(10, 10);
    
    layout.footerReferenceSize = CGSizeMake(10, 10);
    
    layout.minimumLineSpacing = 50;
    
    layout.minimumInteritemSpacing = 20;
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [self initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    presentCellTransitionController = [[PresentCellTransitionController alloc]init];
    [self initActivityInfoData];
    
  

    
}

-(void)initActivityInfoData{
    activityInfoData = [[ActivityInfoData alloc]init];
    allActivityInfoArray = [activityInfoData getAllActivityInfo];
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
    
    NSMutableDictionary *activityInfo = [allActivityInfoArray objectAtIndex:indexPath.row];
    
    // Configure the cell
    [cell.activityImage  setImage:[activityInfo objectForKey:ACTIVITY_INFO_IMAGE]];
    cell.titleLabel.text = [activityInfo objectForKey:ACTIVITY_INFO_TITLE];
    cell.subtitleLabel.text = [activityInfo objectForKey:ACTIVITY_INFO_SUBTITLE];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ActivityViewController * activityViewController = [[ActivityViewController alloc]init];
    activityViewController.activityInofo = [allActivityInfoArray objectAtIndex:indexPath.row];
    activityViewController.transitioningDelegate = self;
    UICollectionViewLayoutAttributes* attributes =  [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellFrame = [self.collectionView convertRect:attributes.frame toView:self.view];
    presentCellTransitionController.cellFrame = cellFrame;
    [self presentViewController:activityViewController animated:YES completion:nil];
}


//Cell 點選轉場動畫
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return presentCellTransitionController;
}



#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
