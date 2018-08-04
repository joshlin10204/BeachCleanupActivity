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
    
    NSLog(@"animateTransition");
    
    ActivityViewController *toViewController = (ActivityViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [[UIScreen mainScreen]bounds];
    [containerView addSubview:toViewController.view];

    
    
    toViewController.basicView.layer.cornerRadius = 14 ;
    toViewController.activityImageView.contentMode = UIViewContentModeScaleToFill;
    toViewController.imageHeightConstraint.constant = self.cellFrame.size.height * 0.7 ;
    toViewController.viewTopConstraint.constant = self.cellFrame.origin.y  ;
    toViewController.viewLeftConstraint.constant = self.cellFrame.origin.x ;
    toViewController.viewRightConstraint.constant = -(bounds.size.width - self.cellFrame.origin.x - self.cellFrame.size.width);
    toViewController.viewBottomConstraint.constant = -(bounds.size.height - self.cellFrame.origin.y - self.cellFrame.size.height);
    [toViewController.view.layer layoutIfNeeded];
    
    
    CGFloat imageHeight = toViewController.view.frame.size.height*0.5;
    UIViewPropertyAnimator * animator =[[UIViewPropertyAnimator alloc]initWithDuration:0.6
                                                                          dampingRatio:0.7
                                                                            animations:^{
                                                                                toViewController.imageHeightConstraint.constant = imageHeight;
                                                                                toViewController.viewTopConstraint.constant = 0 ;
                                                                                toViewController.viewLeftConstraint.constant = 0 ;
                                                                                toViewController.viewRightConstraint.constant = 0;
                                                                                toViewController.viewBottomConstraint.constant = 0;
                                                                                toViewController.basicView.layer.cornerRadius = 0 ;
                                                                                toViewController.activityImageView.contentMode = UIViewContentModeScaleAspectFill;
                                                                                [toViewController.view.layer layoutIfNeeded];
                                                                    
                                                                            }];
    [animator startAnimation];
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition){
        [transitionContext completeTransition:YES];
    }];

    
}

@end
