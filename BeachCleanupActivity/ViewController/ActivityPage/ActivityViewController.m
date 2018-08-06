//
//  ActivityViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityInfoData.h"

@interface ActivityViewController (){
    UIScrollView *scrollView;
    UIView *infoBasicView;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UIButton *signupButton;
}

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initBasicView];
    [self initScrollVIew];
    [self initActivityImageView];
    [self initInfoBasicView];
    [self initTiltleLabel];
    
}

- (void)initBasicView{
    
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
- (void)initScrollVIew{
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.basicView addSubview:scrollView];
    
    NSLayoutConstraint *viewTopConstraint = [scrollView.topAnchor constraintEqualToAnchor:self.basicView.topAnchor];
    NSLayoutConstraint *viewLeftConstraint = [scrollView.leftAnchor constraintEqualToAnchor:self.basicView.leftAnchor];
    NSLayoutConstraint *viewRightConstraint = [scrollView.rightAnchor constraintEqualToAnchor:self.basicView.rightAnchor];
    NSLayoutConstraint *viewBottomConstraint = [scrollView.bottomAnchor constraintEqualToAnchor:self.basicView.bottomAnchor];
    
    viewTopConstraint.active = YES;
    viewLeftConstraint.active = YES;
    viewRightConstraint.active = YES;
    viewBottomConstraint.active = YES;
    
    
    
}
- (void)initActivityImageView{
    
    
    self.activityImageView = [[UIImageView alloc]initWithImage:[self.activityInfo objectForKey:ACTIVITY_INFO_IMAGE]];
    self.activityImageView.clipsToBounds = YES;
    self.activityImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:self.activityImageView];
    
    NSLayoutConstraint *imageTopConstraint = [self.activityImageView.topAnchor constraintEqualToAnchor:self.basicView.topAnchor];
    NSLayoutConstraint *imageLeftConstraint = [self.activityImageView.leftAnchor constraintEqualToAnchor:self.basicView.leftAnchor];
    NSLayoutConstraint *imageRightConstraint = [self.activityImageView.rightAnchor constraintEqualToAnchor:self.basicView.rightAnchor];
    
    self.imageHeightConstraint = [self.activityImageView.heightAnchor constraintEqualToConstant: self.view.frame.size.height *0.5];
    
    imageTopConstraint.active = YES;
    imageLeftConstraint.active = YES;
    imageRightConstraint.active = YES;
    self.imageHeightConstraint.active = YES;
    
}
- (void)initInfoBasicView{
    infoBasicView = [[UIView alloc]init];
    infoBasicView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:infoBasicView];
    
    NSLayoutConstraint *viewTopConstraint = [infoBasicView.topAnchor constraintEqualToAnchor:self.activityImageView.bottomAnchor];
    NSLayoutConstraint *viewLeftConstraint = [infoBasicView.leftAnchor constraintEqualToAnchor:self.basicView.leftAnchor];
    NSLayoutConstraint *viewRightConstraint = [infoBasicView.rightAnchor constraintEqualToAnchor:self.basicView.rightAnchor];
    self.infoBasicViewHeightConstraint = [infoBasicView.heightAnchor constraintEqualToConstant:self.view.frame.size.height *0.2];
    
    NSLog(@"Josh 2 :%f",self.infoBasicViewHeightConstraint.constant);

    viewTopConstraint.active = YES;
    viewLeftConstraint.active = YES;
    viewRightConstraint.active = YES;
    self.infoBasicViewHeightConstraint.active = YES;
    
    
}

- (void)initTiltleLabel{
    
//    CGFloat width = infoBasicView.frame.size.width * 0.6;
//    CGFloat height = infoBasicView.frame.size.height * 0.6;
//    CGFloat x = infoBasicView.frame.size.width *  0.05 ;
//    CGFloat y = 0;
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor colorWithRed:(100.0f / 255.0f) green:(100.0f / 255.0f) blue:(100.0f / 255.0f) alpha:1];
    titleLabel.text = [self.activityInfo objectForKey:ACTIVITY_INFO_TITLE];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [infoBasicView addSubview:titleLabel];
    
    NSLog(@"Josh 3:%f",self.infoBasicViewHeightConstraint.constant);
    NSLog(@"Josh 3:%f",self.infoBasicViewHeightConstraint.constant);

    NSLayoutConstraint *labelTopConstraint = [titleLabel.topAnchor constraintEqualToAnchor:infoBasicView.topAnchor];
    NSLayoutConstraint *labelLeftConstraint = [titleLabel.leftAnchor constraintEqualToAnchor:infoBasicView.leftAnchor constant:self.view.frame.size.width*0.05];
    NSLayoutConstraint *labelRightConstraint = [titleLabel.rightAnchor constraintEqualToAnchor:infoBasicView.rightAnchor];
    NSLayoutConstraint *labelHeightConstraint = [titleLabel.heightAnchor                                                  constraintEqualToConstant:self.infoBasicViewHeightConstraint.constant*0.6];

    
    labelTopConstraint.active = YES;
    labelLeftConstraint.active = YES;
    labelRightConstraint.active = YES;
    labelHeightConstraint. active = YES;
    
    
}
- (void)initSubtitleLabel{
    subtitleLabel = [[UILabel alloc]init];
    subtitleLabel.font = [UIFont boldSystemFontOfSize:30];
    subtitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    subtitleLabel.adjustsFontSizeToFitWidth = YES;
    subtitleLabel.textColor = [UIColor colorWithRed:(200.0f / 255.0f) green:(200.0f / 255.0f) blue:(200.0f / 255.0f) alpha:1];
    subtitleLabel.text = [self.activityInfo objectForKey:ACTIVITY_INFO_SUBTITLE];

    [infoBasicView addSubview:subtitleLabel];
    
    
}

-(void)initSignupButton{
    
}

- (void)initCloseButton{
    
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
