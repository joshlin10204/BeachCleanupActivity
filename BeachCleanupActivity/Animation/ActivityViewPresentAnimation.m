//
//  ActivityViewPresentAnimation.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewPresentAnimation.h"
#import "ActivityViewController.h"


@implementation ActivityViewPresentAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ActivityViewController *activityViewController = (ActivityViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:activityViewController.view];
    
    [self updateViewBeginLayoutConstraint:activityViewController];
    [self presentTransitionContext:transitionContext toActivityView:activityViewController];
    
}

- (void)presentTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext toActivityView:(ActivityViewController*)activityView{
    
    UIViewPropertyAnimator * animator =[[UIViewPropertyAnimator alloc]initWithDuration:0.6
                                                                          dampingRatio:0.7
                                                                            animations:^{
                                                                                [self updateViewEndLayoutConstraint:activityView];
                                                                                
                                                                            }];
    [animator startAnimation];
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition){
        [transitionContext completeTransition:YES];
    }];

    
}

- (void)updateViewBeginLayoutConstraint:(ActivityViewController*)activityView{
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    CGFloat imageHeight = self.cellFrame.size.height * 0.7;
    CGFloat infoBasicViewHeight = self.cellFrame.size.height *0.3;
    CGFloat titleLabelHeight = infoBasicViewHeight *0.6;
    CGFloat subtitleLabelHeight = infoBasicViewHeight *0.3;
    CGFloat labelWidth = self.cellFrame.size.width *0.6;
    CGFloat signupBtnWidth = self.cellFrame.size.width *0.25;
    CGFloat signupBtnHeight= infoBasicViewHeight *0.5;
    
    
    
    activityView.contentView.layer.cornerRadius = 14 ;
    activityView.contentViewHeightConstraint.constant = self.cellFrame.size.height;
    activityView.contentViewWidthConstraint.constant = self.cellFrame.size.width;
    
    activityView.activityImageView.contentMode = UIViewContentModeScaleToFill;
    activityView.imageHeightConstraint.constant =  imageHeight;
    
    activityView.infoBasicViewHeightConstraint.constant = infoBasicViewHeight;
    
    activityView.titleLeftConstraint.constant = self.cellFrame.size.width*0.05;
    activityView.titleHeightConstraint.constant = titleLabelHeight;
    activityView.titleWidthConstraint.constant =  labelWidth;
    
    activityView.subtitleLeftConstraint.constant = self.cellFrame.size.width*0.05;
    activityView.subtitleHeightConstraint.constant = subtitleLabelHeight;
    activityView.subtitleWidthConstraint.constant = labelWidth;
    
    activityView.signupBtnRightConstraint.constant = - self.cellFrame.size.width*0.05;
    activityView.signupBtnHeightConstraint.constant = signupBtnHeight;
    activityView.signupBtneWidthConstraint.constant = signupBtnWidth;
    
    
    activityView.scrollViewTopConstraint.constant = self.cellFrame.origin.y  ;
    activityView.scrollViewLeftConstraint.constant = self.cellFrame.origin.x ;
    activityView.scrollViewRightConstraint.constant = -(bounds.size.width - self.cellFrame.origin.x - self.cellFrame.size.width);
    activityView.scrollViewBottomConstraint.constant = -(bounds.size.height - self.cellFrame.origin.y - self.cellFrame.size.height);
    [activityView.view.layer layoutIfNeeded];
    
}

- (void) updateViewEndLayoutConstraint:(ActivityViewController*)activityView{
    
    CGFloat imageHeight = activityView.view.frame.size.height * 0.4;
    CGFloat height = activityView.view.frame.size.height*2;
    CGFloat width = activityView.view.frame.size.width ;
    activityView.imageHeightConstraint.constant = imageHeight;
    activityView.contentViewHeightConstraint.constant = height;
    activityView.contentViewWidthConstraint.constant = width;
    activityView.scrollViewTopConstraint.constant = 0 ;
    activityView.scrollViewLeftConstraint.constant = 0 ;
    activityView.scrollViewRightConstraint.constant = 0;
    activityView.scrollViewBottomConstraint.constant = 0;
    activityView.contentView.layer.cornerRadius = 0 ;
    activityView.activityImageView.contentMode = UIViewContentModeScaleAspectFill;
    [activityView.view.layer layoutIfNeeded];
}

@end
