//
//  BasicTabBar.h
//  OCleanup
//
//  Created by JoshLin on 2018/7/23.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasicTabBarDelegate<NSObject>

@optional
- (void)onClickHomeBtn;


@end
@interface BasicTabBar : UITabBar

@property (nonatomic, strong) UIButton * homePageBtn;
@property (nonatomic, weak) id <BasicTabBarDelegate> delegate;

@end
