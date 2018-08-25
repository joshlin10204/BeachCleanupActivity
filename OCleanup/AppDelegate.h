//
//  AppDelegate.h
//  OCleanup
//
//  Created by JoshLin on 2018/7/22.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;
@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

