//
//  ActivityViewDismissAnimation.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewDismissAnimation.h"
#import "ActivityViewController.h"

@implementation ActivityViewDismissAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    ActivityViewController *fromViewController = [self getActivityViewController:fromView];
//    [fromViewController.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];//使ScrollView先滑到最頂端
    [self dismissTransitionContext:transitionContext fromActivityView:fromViewController];
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}
- (void)searchScrollViewInView:(UIView *)supView {
    for (UIScrollView *subView in supView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] ) {
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subView];
    }
}
-(ActivityViewController*)getActivityViewController:(UIView*)activityView{
    
    id responder = activityView;
    ActivityViewController *activityViewController;
    while (![responder isKindOfClass: [UIViewController class]] && ![responder isKindOfClass: [UIWindow class]])
    {
        responder = [responder nextResponder];
    }
    if ([responder isKindOfClass: [ActivityViewController class]])
    {
        // responder就是view的
        activityViewController = responder;
    }
    
    return activityViewController;
    
}
- (void) dismissTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext fromActivityView:(ActivityViewController*)activityView{
    
    UIViewPropertyAnimator * animator =[[UIViewPropertyAnimator alloc]initWithDuration:0.6
                                                                          dampingRatio:0.7
                                                                            animations:^{
                                                                                [self updateActivityViewLayoutConstraint:activityView];
                                                                                
                                                                            }];
    [animator startAnimation];
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition){
        [transitionContext completeTransition:YES];
    }];
}

- (void)updateActivityViewLayoutConstraint:(ActivityViewController*)activityView{
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    CGFloat imageHeight = self.cellFrame.size.height * 0.7;
    CGFloat infoBasicViewHeight = self.cellFrame.size.height *0.3;
    CGFloat titleLabelHeight = infoBasicViewHeight *0.6;
    CGFloat subtitleLabelHeight = infoBasicViewHeight *0.3;
    CGFloat labelWidth = self.cellFrame.size.width *0.6;
    CGFloat signupBtnWidth = self.cellFrame.size.width *0.25;
    CGFloat signupBtnHeight= infoBasicViewHeight *0.5;
    
    activityView.scrollView.layer.cornerRadius = 14;
    activityView.closeButton.alpha = 0;
    
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



@end
