//
//  ActivityViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityInfoData.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Josh in");
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initBasicView];
    [self initActivityImageView];
    
}

-(void)initBasicView{
    
    self.basicView = [[UIView alloc] initWithFrame:self.view.frame];
    self.basicView.backgroundColor = [UIColor whiteColor];
    self.basicView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview: self.basicView];
    
    
    
    self.viewTopConstraint = [self.basicView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    self.viewLeftConstraint = [self.basicView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
    self.viewRightConstraint = [self.basicView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.viewBottomConstraint = [self.basicView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    self.viewTopConstraint.active = YES;
    self.viewLeftConstraint.active = YES;
    self.viewRightConstraint.active = YES;
    self.viewBottomConstraint.active = YES;



}
-(void)initActivityImageView{
    
    
    self.activityImageView = [[UIImageView alloc]initWithImage:[self.activityInofo objectForKey:ACTIVITY_INFO_IMAGE]];
    self.activityImageView.clipsToBounds = YES;
    self.activityImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.basicView addSubview:self.activityImageView];
    

    NSLayoutConstraint *imageTopConstraint = [self.activityImageView.topAnchor constraintEqualToAnchor:self.basicView.topAnchor];
    NSLayoutConstraint *imageLeftConstraint = [self.activityImageView.leftAnchor constraintEqualToAnchor:self.basicView.leftAnchor];
    NSLayoutConstraint *imageRightConstraint = [self.activityImageView.rightAnchor constraintEqualToAnchor:self.basicView.rightAnchor];
    self.imageHeightConstraint = [self.activityImageView.heightAnchor constraintEqualToConstant: self.view.frame.size.height *0.5];
    imageTopConstraint.active = YES;
    imageLeftConstraint.active = YES;
    imageRightConstraint.active = YES;
    self.imageHeightConstraint.active = YES;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
