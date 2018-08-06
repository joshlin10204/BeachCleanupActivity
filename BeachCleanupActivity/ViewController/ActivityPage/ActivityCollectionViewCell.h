//
//  ActivityCollectionViewCell.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *activityImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIButton *signupButton;



@end
