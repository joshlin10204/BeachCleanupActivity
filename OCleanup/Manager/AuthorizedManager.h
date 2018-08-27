//
//  AuthorizedManager.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/25.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AccountInfoModel.h"

typedef enum : NSInteger {
    AuthorizekError_LoginFail = 0,
    AuthorizekError_RegisterFail,
    AuthorizekError_UserNotFound,
    AuthorizekError_WrongPassword,
    AuthorizekError_EmailIsEmpty,
    AuthorizekError_EmailNotValid,
    AuthorizekError_EmailAlreadyInUse,
    AuthorizekError_PasswordIsEmpty,
    AuthorizekError_PasswordNotValid,
    AuthorizekError_PasswordNotValidLength,
    AuthorizekError_PasswordHaveSymbol,
    AuthorizekError_ConfirPasswordIsEmpty,
    AuthorizekError_ConfirPasswordNotEqual,
} AuthorizekError;

typedef enum : NSInteger {
    LoginStatusType_NotLogin = 0,
    LoginStatusType_LoginFromFacebook,
    LoginStatusType_LoginFromGooglePlus,
    LoginStatusType_LoginFromEmail,
} LoginStatusType;


@protocol AuthorizeLoginDelegate<NSObject>
@optional
- (void)authorizeLoginDidStart;
- (void)authorizeLoginDidFail:(AuthorizekError)error;
- (void)authorizeLoginDidFinish:(AccountInfoModel*)accountInfo;
@end

@protocol AuthorizeRegisterDelegate<NSObject>
@optional
- (void)authorizeRegisterDidStart;
- (void)authorizeRegisterDidFail:(AuthorizekError)error;
- (void)authorizeRegisterDidFinish:(AccountInfoModel*)accountInfo;
@end


@interface AuthorizedManager : NSObject
@property (nonatomic, weak) id <AuthorizeLoginDelegate> loginDelegate;
@property (nonatomic, weak) id <AuthorizeRegisterDelegate> registerDelegate;

+ (instancetype)sharedInstance;

- (LoginStatusType)currentLoginStatus;

- (void)loginFromEmail:(NSString*)email withPassword:(NSString*)password;

- (void)loginWithFacebookFromViewController:(UIViewController*)viewControler;

- (void)loginWithGooglePlusFromViewController:(UIViewController*)viewControler;

- (void)registereWithEmail:(NSString*)email withPassword:(NSString*)password withConfirmPassword:(NSString*)confirmPassword;

- (void)logout;


@end
