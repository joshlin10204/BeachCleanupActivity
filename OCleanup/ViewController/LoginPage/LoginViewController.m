//
//  LoginViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/21.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Touches View Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}


#pragma mark Click Event

- (IBAction)onClickLoginBtn:(id)sender {
}
- (IBAction)onClickFaceBookBtn:(id)sender {
}
- (IBAction)onClickGooglePlusBtn:(id)sender {
}
- (IBAction)onClickCloseBtn:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
