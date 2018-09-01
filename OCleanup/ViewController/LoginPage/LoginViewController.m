//
//  LoginViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/21.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountRepository.h"
#import "AuthorizedManager.h"
#import "LoadingView.h"


@interface LoginViewController ()<UITextFieldDelegate,AuthorizeLoginDelegate>{
    
    NSString * warnText ;
    LoadingView *loadingView;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.loginButton.layer.cornerRadius =10;
    [self initTexfieldDelegate];
    [self initLoadingView];
    
    [AuthorizedManager sharedInstance].loginDelegate=self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - LoadingView
- (void)initLoadingView{
    loadingView = [[LoadingView alloc]initWithFrame:self.view.frame];
    loadingView.hidden =YES;
    [self.view addSubview:loadingView];
    
}

#pragma mark Touches View Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self closeKeyboard];

}

#pragma mark - UITextField
- (void)initTexfieldDelegate{
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    [self closeKeyboard];
    return YES;
}
- (void)closeKeyboard{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}
#pragma mark -UITextField Enable
- (void)enableAllTextField:(BOOL)isEnable{
    [self.emailTextField setUserInteractionEnabled:isEnable];
    [self.passwordTextField setUserInteractionEnabled:isEnable];
}
#pragma mark -Check TextField
#pragma mark - Warn  Event

-(void)showWarningLabel
{
    self.warnLabel.lineBreakMode=NSLineBreakByWordWrapping;
    self.warnLabel.numberOfLines = 0;
    self.warnLabel.text = warnText;
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.warnLabel.hidden=NO;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:1
                          delay:1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.warnLabel.alpha=0;
                         
                         
                     }
                     completion:^(BOOL finished){
                         self.warnLabel.hidden=YES;
                         self.warnLabel.alpha=1;
                     }];
    
}




#pragma mark Click Event

- (IBAction)onClickLoginBtn:(id)sender {
    loadingView.hidden =NO;
    [[AuthorizedManager sharedInstance]loginFromEmail:self.emailTextField.text
                                         withPassword:self.passwordTextField.text];

}
- (IBAction)onClickFaceBookBtn:(id)sender {
    loadingView.hidden =NO;
    [[AuthorizedManager sharedInstance]loginWithFacebookFromViewController:self];
}
- (IBAction)onClickGooglePlusBtn:(id)sender {
    loadingView.hidden =NO;
    [[AuthorizedManager sharedInstance]loginWithGooglePlusFromViewController:self];
}
- (IBAction)onClickCloseBtn:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - #pragma mark AuthorizedManager Delegate

- (void)authorizeLoginDidStart{
    [self enableAllTextField:NO];
    [self closeKeyboard];
}
- (void)authorizeLoginDidFail:(AuthorizekError)error{
    loadingView.hidden =YES;
    [self enableAllTextField:YES];
    switch (error) {
        case AuthorizekError_LoginFail:
            warnText = @"登入失敗";
            break;
        case AuthorizekError_UserNotFound:
            warnText = @"此帳號尚未註冊";
            break;
        case AuthorizekError_WrongPassword:
            warnText = @"此密碼錯誤";
            break;
        case AuthorizekError_EmailIsEmpty:
            warnText = @"Email 尚未填寫";
            break;
        case AuthorizekError_EmailNotValid:
            warnText = @"Email 格式不對";
            break;
        case AuthorizekError_PasswordIsEmpty:
            warnText = @"密碼尚未填寫";
            break;
        case AuthorizekError_PasswordNotValid:
            warnText = @"密碼長度必須是6到12位數";
            break;
            
        default:
            break;
    }
    [self showWarningLabel];
    
}
-(void)authorizeLoginDidFinish:(NSString *)accountID{
    [[AccountRepository sharedInstance]loadAccountInfoFromAccountID:accountID];
    [[AccountRepository sharedInstance]loadAccountImageFromAccountID:accountID];
    [self enableAllTextField:YES];
    loadingView.hidden =YES;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
