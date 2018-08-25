//
//  AuthorizedManager.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/25.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
@protocol AuthorizeLoginDelegate<NSObject>

@optional
- (void)authorizeLoginDidStart;
- (void)authorizeLoginDidFail:(AuthorizekError)error;
- (void)authorizeLoginDidFinish;

@end

@protocol AuthorizeRegisterDelegate<NSObject>

@optional
- (void)authorizeRegisterDidStart;
- (void)authorizeRegisterDidFail:(AuthorizekError)error;
- (void)authorizeRegisterDidFinish;

@end

@interface AuthorizedManager : NSObject
@property (nonatomic, weak) id <AuthorizeLoginDelegate> loginDelegate;
@property (nonatomic, weak) id <AuthorizeRegisterDelegate> registerDelegate;


+ (instancetype)sharedInstance;

- (void)loginFromEmail:(NSString*)email withPassword:(NSString*)password;

- (void)loginWithFacebookFromViewController:(UIViewController*)viewControler;

- (void)loginWithGooglePlusFromViewController:(UIViewController*)viewControler;

- (void)registereWithEmail:(NSString*)email withPassword:(NSString*)password withConfirmPassword:(NSString*)confirmPassword;

@end
