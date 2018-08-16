//
//  TicketsCollectionViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/15.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketsCollectionViewController.h"
#import "TicketsCollectionViewFlowLayout.h"
#import "TicketsCollectionViewCell.h"
#import "TicketsData.h"


@interface TicketsCollectionViewController (){
    NSMutableArray * allTicketsArray;
    TicketsData *ticketsData;

}

@end

@implementation TicketsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    self = [super init];
    
    TicketsCollectionViewFlowLayout * layout = [[TicketsCollectionViewFlowLayout alloc]init];

    return [self initWithCollectionViewLayout:layout];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.userInteractionEnabled = true; //???
    [self.collectionView registerClass:[TicketsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self initTicektsData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //NavigationBar 設置透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)initTicektsData{
    ticketsData = [[TicketsData alloc]init];
    allTicketsArray = [ticketsData getAllTickets];
    [self.collectionView reloadData];

}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return allTicketsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //增加Cell 陰影
    cell.layer.cornerRadius=14;
    cell.layer.shadowOpacity = 0.6;
    cell.layer.shadowRadius = 5;
    cell.layer.shadowColor = [[UIColor colorWithRed:(100.0f / 255.0f) green:(100.0f/255.0f) blue:(100.0f/255.0f) alpha:1]CGColor];
    
    return cell;
}


@end
