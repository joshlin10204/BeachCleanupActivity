//
//  RegisteredViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/21.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()<UITextFieldDelegate>

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.phoneTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Touches View Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];

}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}


#pragma mark Click Event
- (IBAction)onClickRegisteredBtn:(id)sender {
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
