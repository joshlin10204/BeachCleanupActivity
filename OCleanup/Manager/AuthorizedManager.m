//
//  AuthorizedManager.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/25.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#define AUTHORIZED_MANAGER_LOGIN_STATUS @"loginStatus"

#import "AuthorizedManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import Firebase;
@import GoogleSignIn;


static AuthorizedManager *instance;
static dispatch_once_t onceToken;
@interface AuthorizedManager()<GIDSignInUIDelegate,GIDSignInDelegate>{
    AccountInfoModel *accountInfoModel;
    AuthorizekError  authorizekError;
    LoginStatusType loginStatus;
}

@end
@implementation AuthorizedManager
+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (LoginStatusType)currentLoginStatus{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:AUTHORIZED_MANAGER_LOGIN_STATUS]) {
        loginStatus =[defaults integerForKey:AUTHORIZED_MANAGER_LOGIN_STATUS];
    }else{
        loginStatus =LoginStatusType_NotLogin;
    }
    return loginStatus;
}

- (void)setLoginStatus:(LoginStatusType)status{
    loginStatus = status;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:loginStatus forKey:AUTHORIZED_MANAGER_LOGIN_STATUS];
}
#pragma mark  - Login
#pragma mark  -Email

- (void)loginFromEmail:(NSString*)email withPassword:(NSString*)password{
    
    [self.loginDelegate authorizeLoginDidStart];
    if (![self isValidEmail:email] ||![self isValidPassword:password]) {
        [self.loginDelegate authorizeLoginDidFail:authorizekError];
    }else{
        [[FIRAuth auth]signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (!error) {
                [self.loginDelegate authorizeLoginDidFinish:[self getAccountInfo:authResult]];
                [self setLoginStatus:LoginStatusType_LoginFromEmail];
            }else{
                if (error.code == 17011) {
                    [self.loginDelegate authorizeLoginDidFail:AuthorizekError_UserNotFound];
                }else if(error.code ==17009){
                    [self.loginDelegate authorizeLoginDidFail:AuthorizekError_WrongPassword];
                }else{
                    [self.loginDelegate authorizeLoginDidFail:AuthorizekError_LoginFail];
                }
            }
        }];
    }
}

#pragma mark  -Facebook

- (void)loginWithFacebookFromViewController:(UIViewController*)viewControler{
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc]init];
    [manager logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController:viewControler handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (!error && !result.isCancelled) {
            if ([FBSDKAccessToken currentAccessToken]) {
                FIRAuthCredential * credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                [self registerWithFIRAuthCredential:credential];
                [self setLoginStatus:LoginStatusType_LoginFromFacebook];

            }else{
                [self.loginDelegate authorizeLoginDidFail:AuthorizekError_LoginFail];
            }
        }else{
            [self.loginDelegate authorizeLoginDidFail:AuthorizekError_LoginFail];
        }
    }];

    
    
}
#pragma mark  -GooglePlus

- (void)loginWithGooglePlusFromViewController:(UIViewController*)viewControler{
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self ;
    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
    [[GIDSignIn sharedInstance] signIn];
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        [self registerWithFIRAuthCredential:credential];
        [self setLoginStatus:LoginStatusType_LoginFromGooglePlus];


    } else {
        [self.loginDelegate authorizeLoginDidFail:AuthorizekError_LoginFail];
    }
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {}

- (void)registerWithFIRAuthCredential:(FIRAuthCredential*)credential {
    [[FIRAuth auth]signInAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (!error) {
            [self.loginDelegate authorizeLoginDidFinish:[self getAccountInfo:authResult]];
        }else{
            [self.loginDelegate authorizeLoginDidFail:AuthorizekError_LoginFail];
            [self setLoginStatus:LoginStatusType_NotLogin];
        }
    }];
}


#pragma mark  - Registere

- (void)registereWithEmail:(NSString*)email withPassword:(NSString*)password withConfirmPassword:(NSString*)confirmPassword{
    
    [self.registerDelegate authorizeRegisterDidStart];
    if (![self isValidEmail:email]||![self isValidPassword:password]||
        ![self isValidConfirmPassword:confirmPassword withPassword:password]) {
        
        [self.registerDelegate authorizeRegisterDidFail:authorizekError];
        
    }else{
        [[FIRAuth auth]createUserWithEmail:email
                                  password:password
                                completion:^(FIRAuthDataResult * _Nullable authResult,
                                             NSError * _Nullable error) {
                                    if (!error) {
                                        [self.registerDelegate authorizeRegisterDidFinish:[self getAccountInfo:authResult]];
                                        [self setLoginStatus:LoginStatusType_LoginFromEmail];
                                    }else{
                                        if (error.code ==17007) {
                                            [self.registerDelegate authorizeRegisterDidFail:AuthorizekError_EmailAlreadyInUse];

                                        }else{
                                            [self.registerDelegate authorizeRegisterDidFail:AuthorizekError_RegisterFail];
                                            [self setLoginStatus:LoginStatusType_NotLogin];
                                        }
                                    }
                                }];
    }

}
#pragma mark - FIRAuthDataResult

- (AccountInfoModel*)getAccountInfo:(FIRAuthDataResult*)result{
    
    FIRUser *user = result.user;
    accountInfoModel = [[AccountInfoModel alloc]init];
    accountInfoModel.accountId = user.uid;
    accountInfoModel.name = user.displayName;
    accountInfoModel.email = user.email;
    accountInfoModel.phone = user.phoneNumber;
    NSString *imageString = [NSString stringWithFormat:@"%@?type=large",user.photoURL];
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    accountInfoModel.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    return accountInfoModel;
}
#pragma mark  - Logout

- (void)logout{
    [self setLoginStatus:LoginStatusType_NotLogin];
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
}


#pragma mark  - Validation Information
- (BOOL)isValidEmail:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *checkEmailText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    if (email.length==0) {
        authorizekError = AuthorizekError_EmailIsEmpty;
        return NO;
    }else if (![checkEmailText evaluateWithObject:email]){
        authorizekError = AuthorizekError_EmailNotValid;
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isValidPassword:(NSString*)password{
    if (password.length ==0) {
        authorizekError = AuthorizekError_PasswordIsEmpty;
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isValidConfirmPassword:(NSString*)confirmPassword withPassword:(NSString*)password{
    NSRegularExpression *numRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"
                                                                                          options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numMatchCount = [numRegularExpression numberOfMatchesInString:password
                                                                    options:NSMatchingReportProgress
                                                                      range:NSMakeRange(0,password.length)];
    
    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"
                                                                                             options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:password
                                                                          options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    if (confirmPassword.length ==0) {
        authorizekError = AuthorizekError_ConfirPasswordIsEmpty;
        return NO;
    }else if(![confirmPassword isEqualToString:password]){
        authorizekError = AuthorizekError_ConfirPasswordNotEqual;
        return NO;
    }
    else if(password.length<6 || password.length>12){
        authorizekError = AuthorizekError_PasswordNotValidLength;
        return NO;
    }else if(numMatchCount==password.length||letterMatchCount==password.length){
        authorizekError = AuthorizekError_PasswordNotValid;
        return NO;
    }else if(numMatchCount+letterMatchCount!=password.length){
        authorizekError = AuthorizekError_PasswordHaveSymbol;
        return NO;
    }else{
        return YES;
    }
}


//FIRUser *user = [[FIRAuth auth] currentUser];
//
//if (user == nil) {
//    NSLog(@"尚未登入！！");
//}else{
//    NSLog(@"已經登入了！:%@",user);
    //                [[FIRAuth auth].currentUser updateEmail:@"TestEmail@email.com" completion:^(NSError *_Nullable error) {
//    //                    // ...
//    //                    if (error) {
//    //                        NSLog(@"更新Email 失敗:%@",error);
//    //                    }else{
//    //                        NSLog(@"更新Email 成功");
//    //
//    //                    }
//    //                }];
//}





@end
