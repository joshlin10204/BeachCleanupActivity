//
//  ActivityViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityInfoData.h"

@interface ActivityViewController ()<UIViewControllerTransitioningDelegate>{
    
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



    
    [self initScrollVIew];
    [self initContentView];
    [self initActivityImageView];
    [self initInfoBasicView];
    [self initTiltleLabel];
    [self initSubtitleLabel];
    [self initSignupButton];
    [self initCloseButton];
}

- (void)initScrollVIew{
    CGFloat height = self.view.frame.size.height ;
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(0,height*2);//暫時設定兩倍長度
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//避免出現空白
    [self.view addSubview:self.scrollView];
    
    self.scrollViewTopConstraint = [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    self.scrollViewLeftConstraint = [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
    self.scrollViewRightConstraint = [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.scrollViewBottomConstraint = [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    self.scrollViewTopConstraint.active = YES;
    self.scrollViewLeftConstraint.active = YES;
    self.scrollViewRightConstraint.active = YES;
    self.scrollViewBottomConstraint.active = YES;
    
    
    
}


- (void)initContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.frame];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview: self.contentView];
    
    NSLayoutConstraint *viewTopConstraint = [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor];
    NSLayoutConstraint *viewLeftConstraint = [self.contentView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor];
    self.contentViewHeightConstraint = [self.contentView.heightAnchor constraintEqualToConstant:self.view.frame.size.height];
    self.contentViewWidthConstraint = [self.contentView.widthAnchor constraintEqualToConstant:self.view.frame.size.width];

    viewTopConstraint.active = YES;
    viewLeftConstraint.active = YES;
    self.contentViewHeightConstraint.active = YES;
    self.contentViewWidthConstraint.active = YES;
    
    
}
- (void)initActivityImageView{
    
    
    self.activityImageView = [[UIImageView alloc]initWithImage:[self.activityInfo objectForKey:ACTIVITY_INFO_IMAGE]];
    self.activityImageView.clipsToBounds = YES;
    self.activityImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.activityImageView];
    
    NSLayoutConstraint *imageTopConstraint = [self.activityImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor];
    NSLayoutConstraint *imageLeftConstraint = [self.activityImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor];
    NSLayoutConstraint *imageRightConstraint = [self.activityImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor];

    self.imageHeightConstraint = [self.activityImageView.heightAnchor constraintEqualToConstant:self.view.frame.size.height];
    
    imageTopConstraint.active = YES;
    imageLeftConstraint.active = YES;
    imageRightConstraint.active = YES;
    self.imageHeightConstraint.active = YES;
    
}
- (void)initInfoBasicView{
    infoBasicView = [[UIView alloc]init];
    infoBasicView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:infoBasicView];
    
    NSLayoutConstraint *viewTopConstraint = [infoBasicView.topAnchor constraintEqualToAnchor:self.activityImageView.bottomAnchor];
    NSLayoutConstraint *viewLeftConstraint = [infoBasicView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor];
    NSLayoutConstraint *viewRightConstraint = [infoBasicView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor];
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
    self.titleHeightConstraint = [titleLabel.heightAnchor constraintEqualToConstant:infoBasicView.frame.size.height];
    self.titleWidthConstraint = [titleLabel.widthAnchor constraintEqualToConstant:infoBasicView.frame.size.width];

    
    labelTopConstraint.active = YES;
    self.titleLeftConstraint.active = YES;
    self.titleHeightConstraint.active = YES;
    self.titleWidthConstraint.active = YES;

    
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
    self.subtitleHeightConstraint = [subtitleLabel.heightAnchor constraintEqualToConstant:infoBasicView.frame.size.height];
    self.subtitleWidthConstraint = [subtitleLabel.widthAnchor constraintEqualToConstant:infoBasicView.frame.size.width];

    labelTopConstraint.active = YES;
    self.subtitleLeftConstraint.active = YES;
    self.subtitleHeightConstraint.active = YES;
    self.subtitleWidthConstraint.active = YES;

}

-(void)initSignupButton{
    signupButton = [[UIButton alloc]init];
    signupButton.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f)
                                                   green:(117.0f/255.0f)
                                                    blue:(134.0f/255.0f)
                                                   alpha:1];
    signupButton.translatesAutoresizingMaskIntoConstraints = NO;
    signupButton.layer.cornerRadius = 20;
    signupButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [signupButton setTitle:@"報名" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signupButton addTarget:self
                     action:@selector(onClickSignupBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    [infoBasicView addSubview:signupButton];
    
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:signupButton
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:infoBasicView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1
                                                                            constant:0];
    self.signupBtnRightConstraint = [signupButton.rightAnchor constraintEqualToAnchor:infoBasicView.rightAnchor];
    self.signupBtnHeightConstraint = [signupButton.heightAnchor constraintEqualToConstant:infoBasicView.frame.size.height];
    self.signupBtneWidthConstraint= [signupButton.widthAnchor constraintEqualToConstant:infoBasicView.frame.size.width];

    buttonTopConstraint.active = YES;
    self.signupBtnRightConstraint.active = YES;
    self.signupBtnHeightConstraint.active = YES;
    self.signupBtneWidthConstraint.active = YES;
    

    
}
- (void)onClickSignupBtn:(id)sender{
    NSLog(@"onClickSignupBtn");
    
}

- (void)initCloseButton{
    
    self.closeButton = [[UIButton alloc]init];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.closeButton setImage:[UIImage imageNamed:@"Button_Close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self
                    action:@selector(onClickCloseBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    CGFloat width = self.view.frame.size.width *0.1;
    NSLayoutConstraint *buttonTopConstraint = [self.closeButton.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                                                                    constant:width * 0.5];
    NSLayoutConstraint *buttonRightConstraint = [self.closeButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor
                                                                                        constant:-width * 0.5];
    NSLayoutConstraint *buttonHeightConstraint = [self.closeButton.heightAnchor constraintEqualToConstant:width];
    NSLayoutConstraint *buttonWidthConstraint = [self.closeButton.widthAnchor constraintEqualToConstant:width];
    
    buttonTopConstraint.active = YES;
    buttonRightConstraint.active = YES;
    buttonHeightConstraint.active = YES;
    buttonWidthConstraint.active = YES;
    
}

- (void)onClickCloseBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
