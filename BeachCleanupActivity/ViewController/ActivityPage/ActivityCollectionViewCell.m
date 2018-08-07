//
//  ActivityCollectionViewCell.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/29.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityCollectionViewCell.h"
@interface ActivityCollectionViewCell(){
    
    UIView * infoBasicView;
    
}
@end

@implementation ActivityCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCellBasicView];
        [self initActivityImage];
        [self initInfoBasicView];
    }
    
    return self;
}
- (void)initCellBasicView{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius=14;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowRadius = 5;
    self.layer.shadowColor = [[UIColor colorWithRed:(100.0f / 255.0f) green:(100.0f/255.0f) blue:(100.0f/255.0f) alpha:1]CGColor];
}


- (void)initActivityImage{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height *0.7;
    self.activityImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.activityImage.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(14, 14)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.activityImage.frame;
    maskLayer.path = maskPath.CGPath;
    self.activityImage.layer.mask = maskLayer;
    [self.contentView addSubview:self.activityImage];

}

- (void)initInfoBasicView{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height *0.3;
    CGFloat x = 0 ;
    CGFloat y = self.frame.size.height - height;
    infoBasicView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [self.contentView addSubview:infoBasicView];
    [self initTitleLabel];
    [self initSubtitleLabel];
    [self initSignupButton];
}

- (void)initTitleLabel{
    CGFloat width = infoBasicView.frame.size.width * 0.6;
    CGFloat height = infoBasicView.frame.size.height * 0.6;
    CGFloat x = infoBasicView.frame.size.width *  0.05 ;
    CGFloat y = 0;
    
    NSLog(@"Josh cell :%f",x);
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textColor = [UIColor colorWithRed:(100.0f / 255.0f) green:(100.0f / 255.0f) blue:(100.0f / 255.0f) alpha:1];
    [infoBasicView addSubview:self.titleLabel];
    
}
- (void)initSubtitleLabel{
    CGFloat width = infoBasicView.frame.size.width * 0.6;
    CGFloat height = infoBasicView.frame.size.height * 0.3;
    CGFloat x = infoBasicView.frame.size.width *  0.05 ;
    CGFloat y = self.titleLabel.frame.size.height;
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.subtitleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.subtitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.subtitleLabel.adjustsFontSizeToFitWidth = YES;
    self.subtitleLabel.textColor = [UIColor colorWithRed:(200.0f / 255.0f) green:(200.0f / 255.0f) blue:(200.0f / 255.0f) alpha:1];
    [infoBasicView addSubview:self.subtitleLabel];
    
}
- (void)initSignupButton{
    CGFloat width = infoBasicView.frame.size.width * 0.25;
    CGFloat height = infoBasicView.frame.size.height * 0.5;
    CGFloat x = infoBasicView.frame.size.width - infoBasicView.frame.size.width * 0.05 - width  ;
    CGFloat y = infoBasicView.frame.size.height /2 - height/2;
    self.signupButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.signupButton.layer.cornerRadius = 20;
    self.signupButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.signupButton setTitle:@"報名" forState:UIControlStateNormal];
    [self.signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signupButton.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(117.0f/255.0f) blue:(134.0f/255.0f) alpha:1];
    [self.signupButton addTarget:self
                        action:@selector(onClickJoinBtn:)
              forControlEvents:UIControlEventTouchUpInside];
    [infoBasicView addSubview:self.signupButton];
    
}
- (void)onClickJoinBtn:(id)sender{
    
    NSLog(@"onClickJoinBtn");
    
    
}
@end
