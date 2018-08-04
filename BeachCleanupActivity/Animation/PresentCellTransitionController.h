//
//  PresentCellTransitionController.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/4.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentCellTransitionController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, nonatomic) CGRect cellFrame;

@end
