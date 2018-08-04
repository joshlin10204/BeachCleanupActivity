//
//  ActivityViewController.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController
@property (strong,nonatomic)NSMutableDictionary *activityInofo;

@property (strong,nonatomic)UIView *basicView;
@property (strong,nonatomic)UIImageView *activityImageView;

@property (strong,nonatomic)NSLayoutConstraint *viewTopConstraint;
@property (strong,nonatomic)NSLayoutConstraint *viewLeftConstraint;
@property (strong,nonatomic)NSLayoutConstraint *viewRightConstraint;
@property (strong,nonatomic)NSLayoutConstraint *viewBottomConstraint;
@property (strong,nonatomic)NSLayoutConstraint *imageHeightConstraint;




@end
