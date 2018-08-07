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

@property (strong,nonatomic)UIView *basicView;
@property (strong,nonatomic)UIImageView *activityImageView;
@property (strong,nonatomic)NSLayoutConstraint *basicViewTopConstraint;
@property (strong,nonatomic)NSLayoutConstraint *basicViewLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *basicViewRightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *basicViewBottomConstraint;
@property (strong,nonatomic)NSLayoutConstraint *imageHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *infoBasicViewHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *titleRightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleHeightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *subtitleRightConstraint;







@end
