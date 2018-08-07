//
//  PresentCellTransitionController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/4.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "PresentCellTransitionController.h"
#import "ActivityViewController.h"

@implementation PresentCellTransitionController
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
        
    ActivityViewController *toViewController = (ActivityViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];

    [self updateActivityViewLayoutConstraint:toViewController];
    [self presentTransitionContext:transitionContext toActivityView:toViewController];

}

- (void)updateActivityViewLayoutConstraint:(ActivityViewController*)activityView{
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    CGFloat imageHeight = self.cellFrame.size.height * 0.7;
    CGFloat infoBasicViewHeight = self.cellFrame.size.height *0.3;
    CGFloat titleLabelHeight = infoBasicViewHeight *0.6;
    CGFloat subtitleLabelHeight = infoBasicViewHeight *0.3;
    
    
    activityView.basicView.layer.cornerRadius = 14 ;
    activityView.activityImageView.contentMode = UIViewContentModeScaleToFill;
    activityView.imageHeightConstraint.constant =  imageHeight;
    activityView.infoBasicViewHeightConstraint.constant = infoBasicViewHeight;
    activityView.titleHeightConstraint.constant = titleLabelHeight;
    activityView.subtitleHeightConstraint.constant = subtitleLabelHeight;
    
    activityView.titleLeftConstraint.constant = self.cellFrame.size.width*0.05;
    activityView.titleRightConstraint.constant =  - self.cellFrame.size.width*0.4;
    activityView.subtitleLeftConstraint.constant = self.cellFrame.size.width*0.05;
    activityView.subtitleRightConstraint.constant =  - self.cellFrame.size.width*0.4;

    activityView.basicViewTopConstraint.constant = self.cellFrame.origin.y  ;
    activityView.basicViewLeftConstraint.constant = self.cellFrame.origin.x ;
    activityView.basicViewRightConstraint.constant = -(bounds.size.width - self.cellFrame.origin.x - self.cellFrame.size.width);
    activityView.basicViewBottomConstraint.constant = -(bounds.size.height - self.cellFrame.origin.y - self.cellFrame.size.height);
    [activityView.view.layer layoutIfNeeded];
 
}

- (void) presentTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext toActivityView:(ActivityViewController*)activityView{
    
    CGFloat imageHeight = activityView.view.frame.size.height * 0.5;
    UIViewPropertyAnimator * animator =[[UIViewPropertyAnimator alloc]initWithDuration:0.6
                                                                          dampingRatio:0.7
                                                                            animations:^{
                                                                                activityView.imageHeightConstraint.constant = imageHeight;
                                                                                activityView.basicViewTopConstraint.constant = 0 ;
                                                                                activityView.basicViewLeftConstraint.constant = 0 ;
                                                                                activityView.basicViewRightConstraint.constant = 0;
                                                                                activityView.basicViewBottomConstraint.constant = 0;
                                                                                activityView.basicView.layer.cornerRadius = 0 ;
                                                                                activityView.activityImageView.contentMode = UIViewContentModeScaleAspectFill;
                                                                                [activityView.view.layer layoutIfNeeded];
                                                                                
                                                                            }];
    [animator startAnimation];
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition){
            [transitionContext completeTransition:YES];
    }];
}

@end
