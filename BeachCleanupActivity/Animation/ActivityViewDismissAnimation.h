//
//  ActivityViewDismissAnimation.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityViewDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, nonatomic) CGRect cellFrame;

@end