//
//  RegisteredViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/21.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "RegisteredViewController.h"
#import "AccountRepository.h"
#import "AuthorizedManager.h"
#import "LoadingView.h"

@interface RegisteredViewController ()<UITextFieldDelegate,AuthorizeRegisterDelegate>{
    CGFloat spacingWithKeyboardAndCursor;
    NSString * warnText ;
    LoadingView *loadingView;

}

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registeredButton.layer.cornerRadius =10;
    [self initTexfieldDelegate];
    [self registerNotification];
    [self initLoadingView];

    [AuthorizedManager sharedInstance].registerDelegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Keyboard Event
- (void)registerNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGFloat moveHeight = self.view.frame.size.height-self.registeredButton.frame.origin.y;
    
    spacingWithKeyboardAndCursor = keyboardHeight - moveHeight;
    if (spacingWithKeyboardAndCursor > 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.frame = CGRectMake(0.0f, -(spacingWithKeyboardAndCursor), self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    if (spacingWithKeyboardAndCursor > 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
#pragma mark - LoadingView
- (void)initLoadingView{
    loadingView = [[LoadingView alloc]initWithFrame:self.view.frame];
    loadingView.hidden =YES;
    [self.view addSubview:loadingView];
    
}

#pragma mark Touches View Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    
}


#pragma mark - UITextField
- (void)initTexfieldDelegate{
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -UITextField Enable
- (void)enableAllTextField:(BOOL)isEnable{
    [self.emailTextField setUserInteractionEnabled:isEnable];
    [self.passwordTextField setUserInteractionEnabled:isEnable];
    [self.confirmTextField setUserInteractionEnabled:isEnable];
    [self.nameTextField setUserInteractionEnabled:isEnable];
    [self.phoneTextField setUserInteractionEnabled:isEnable];
}



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



#pragma mark - Click Event
- (IBAction)onClickRegisteredBtn:(id)sender {

    loadingView.hidden =NO;

    [[AuthorizedManager sharedInstance]registereWithEmail:self.emailTextField.text withPassword:self.passwordTextField.text withConfirmPassword:self.confirmTextField.text];
}
- (IBAction)onClickCloseBtn:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AuthorizedManager Delegate
-(void)authorizeRegisterDidStart{
    
}
-(void)authorizeRegisterDidFail:(AuthorizekError)error{
    loadingView.hidden =YES;

    [self enableAllTextField:YES];
    switch (error) {
        case AuthorizekError_RegisterFail:
            warnText = @"註冊失敗";
            break;
        case AuthorizekError_EmailAlreadyInUse:
            warnText = @"此帳號已註冊";
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
            warnText = @"密碼必須包含英文及數字";
            break;
        case AuthorizekError_PasswordNotValidLength:
            warnText = @"密碼長度必須是6到12位數";
            break;
        case AuthorizekError_PasswordHaveSymbol:
            warnText = @"密碼不能有特殊符號";
            break;
        case AuthorizekError_ConfirPasswordIsEmpty:
            warnText = @"確認密碼 尚未填寫";
            break;
        case AuthorizekError_ConfirPasswordNotEqual:
            warnText = @"兩次密碼填寫不相同";
            break;
        default:
            break;
    }
    [self showWarningLabel];
    
}
-(void)authorizeRegisterDidFinish:(NSString *)accountID{
    
    loadingView.hidden =NO;
    [[AccountRepository sharedInstance]loadAccountInfoFromAccountID:accountID];
    [[AccountRepository sharedInstance]loadAccountImageFromAccountID:accountID];
    [self enableAllTextField:YES];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
