//
//  ActivityViewController.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController
@property (strong,nonatomic)NSMutableDictionary *activityInfo;
@property (strong,nonatomic)UIView *contentView;
@property (strong,nonatomic)UIImageView *activityImageView;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIButton *closeButton;

@property (strong,nonatomic)NSLayoutConstraint *scrollViewTopConstraint;
@property (strong,nonatomic)NSLayoutConstraint *scrollViewLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *scrollViewRightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *scrollViewBottomConstraint;
@property (strong,nonatomic)NSLayoutConstraint *contentViewHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *contentViewWidthConstraint;

@property (strong,nonatomic)NSLayoutConstraint *imageHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *infoBasicViewHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleWidthConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleWidthConstraint;
@property (strong,nonatomic)NSLayoutConstraint *signupBtnRightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *signupBtnHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *signupBtneWidthConstraint;






@end
