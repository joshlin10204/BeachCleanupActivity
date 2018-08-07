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
    UIButton *closeButton;
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
    [self initSignupButton];
    [self initCloseButton];
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
    
    closeButton = [[UIButton alloc]init];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [closeButton setImage:[UIImage imageNamed:@"Button_Close"] forState:UIControlStateNormal];
    [closeButton addTarget:self
                    action:@selector(onClickCloseBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    CGFloat width = self.view.frame.size.width *0.1;
    NSLayoutConstraint *buttonTopConstraint = [closeButton.topAnchor constraintEqualToAnchor:self.activityImageView.topAnchor
                                                                                    constant:width * 0.5];
    NSLayoutConstraint *buttonRightConstraint = [closeButton.rightAnchor constraintEqualToAnchor:self.activityImageView.rightAnchor
                                                                                        constant:-width * 0.5];
    NSLayoutConstraint *buttonHeightConstraint = [closeButton.heightAnchor constraintEqualToConstant:width];
    NSLayoutConstraint *buttonWidthConstraint = [closeButton.widthAnchor constraintEqualToConstant:width];
    
    buttonTopConstraint.active = YES;
    buttonRightConstraint.active = YES;
    buttonHeightConstraint.active = YES;
    buttonWidthConstraint.active = YES;
    

    
}

- (void)onClickCloseBtn:(id)sender{
    NSLog(@"Close");
    [self dismissViewControllerAnimated:YES completion:^{

    }];
    
    
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
