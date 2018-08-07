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
    [self initSubtitleLabel];
}

- (void)initBasicView{
    
    self.basicView = [[UIView alloc] initWithFrame:self.view.frame];
    self.basicView.backgroundColor = [UIColor whiteColor];
    self.basicView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: self.basicView];
    
    self.basicViewTopConstraint = [self.basicView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    self.basicViewLeftConstraint = [self.basicView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
    self.basicViewRightConstraint = [self.basicView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.basicViewBottomConstraint = [self.basicView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    self.basicViewTopConstraint.active = YES;
    self.basicViewLeftConstraint.active = YES;
    self.basicViewRightConstraint.active = YES;
    self.basicViewBottomConstraint.active = YES;
    
    
    
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
    self.imageHeightConstraint = [self.activityImageView.heightAnchor constraintEqualToConstant:self.view.frame.size.height];
    
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
    self.infoBasicViewHeightConstraint = [infoBasicView.heightAnchor constraintEqualToConstant:100];
    
    viewTopConstraint.active = YES;
    viewLeftConstraint.active = YES;
    viewRightConstraint.active = YES;
    self.infoBasicViewHeightConstraint.active = YES;
    
    
}

- (void)initTiltleLabel{
    
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLabel.textColor = [UIColor colorWithRed:(100.0f / 255.0f)
                                           green:(100.0f / 255.0f)
                                            blue:(100.0f / 255.0f)
                                           alpha:1];
    titleLabel.text = [self.activityInfo objectForKey:ACTIVITY_INFO_TITLE];
    [infoBasicView addSubview:titleLabel];
    
    
    
    NSLayoutConstraint *labelTopConstraint = [titleLabel.topAnchor constraintEqualToAnchor:infoBasicView.topAnchor];
    self.titleLeftConstraint = [titleLabel.leftAnchor constraintEqualToAnchor:infoBasicView.leftAnchor];
    self.titleRightConstraint = [titleLabel.rightAnchor constraintEqualToAnchor:infoBasicView.rightAnchor];
    self.titleHeightConstraint = [titleLabel.heightAnchor constraintEqualToConstant:infoBasicView.frame.size.height];
    
    labelTopConstraint.active = YES;
    self.titleLeftConstraint.active = YES;
    self.titleRightConstraint.active = YES;
    self.titleHeightConstraint.active = YES;
    
    
}
- (void)initSubtitleLabel{
    subtitleLabel = [[UILabel alloc]init];
    subtitleLabel.adjustsFontSizeToFitWidth = YES;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.font = [UIFont boldSystemFontOfSize:20];
    subtitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    subtitleLabel.textColor = [UIColor colorWithRed:(200.0f / 255.0f)
                                              green:(200.0f / 255.0f)
                                               blue:(200.0f / 255.0f)
                                              alpha:1];
    subtitleLabel.text = [self.activityInfo objectForKey:ACTIVITY_INFO_SUBTITLE];
    [infoBasicView addSubview:subtitleLabel];
    
    
    NSLayoutConstraint *labelTopConstraint = [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor];
    self.subtitleLeftConstraint = [subtitleLabel.leftAnchor constraintEqualToAnchor:infoBasicView.leftAnchor];
    self.subtitleRightConstraint = [subtitleLabel.rightAnchor constraintEqualToAnchor:infoBasicView.rightAnchor];
    self.subtitleHeightConstraint = [subtitleLabel.heightAnchor constraintEqualToConstant:infoBasicView.frame.size.height];
    
    
    labelTopConstraint.active = YES;
    self.subtitleLeftConstraint.active = YES;
    self.subtitleRightConstraint.active = YES;
    self.subtitleHeightConstraint.active = YES;
    
    
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
