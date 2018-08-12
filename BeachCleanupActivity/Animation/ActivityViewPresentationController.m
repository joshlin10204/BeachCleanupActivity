//
//  ActivityViewPresentationController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/10.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityViewPresentationController.h"
#import "ActivityViewPresentAnimation.h"
#import "ActivityViewDismissAnimation.h"

@interface ActivityViewPresentationController(){
    ActivityViewPresentAnimation *  activityViewPresentAnimation;
    ActivityViewDismissAnimation * activityViewDismissAnimation;
}
@end

@implementation ActivityViewPresentationController

- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    return self;
}


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom
//        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        presentedViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        presentedViewController.providesPresentationContextTransitionStyle = YES;
        presentedViewController.definesPresentationContext = YES;
        

    
    }
    
    return self;
}
- (void)dismissalTransitionWillBegin
{
    NSLog(@"dismissalTransitionWillBegin");
}


//Cell 點選轉場動畫
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    activityViewPresentAnimation = [[ActivityViewPresentAnimation alloc]init];
    activityViewPresentAnimation.cellFrame = self.cellFrame;
    

    return activityViewPresentAnimation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    activityViewDismissAnimation = [[ActivityViewDismissAnimation alloc]init];
    activityViewDismissAnimation.cellFrame = self.cellFrame;
    return activityViewDismissAnimation;

}

//- (BOOL)shouldRemovePresentersView {
//    return YES;
//}

@end
