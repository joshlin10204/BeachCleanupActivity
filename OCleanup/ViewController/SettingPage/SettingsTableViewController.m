//
//  SettingsTableViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "LoginViewController.h"
#import "AuthorizedManager.h"
#import "AccountRepository.h"


@interface SettingsTableViewController (){
    LoginStatusType loginStatusType;
    
    
}

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkCurrentLoginStatus];
    
}
- (void)checkCurrentLoginStatus{
    loginStatusType = [[AuthorizedManager sharedInstance]currentLoginStatus];
    if (loginStatusType ==LoginStatusType_NotLogin) {
        self.logoutCell.textLabel.text=@"登入";
        
    }else{
        self.logoutCell.textLabel.text=@"登出";
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (loginStatusType==LoginStatusType_NotLogin) {
        if (cell ==self.logoutCell || cell==self.userInfoCell) {
            [self presenLoginViewController];
        }
    }else{
        if (cell ==self.logoutCell) {
            [self presentLogOutAlert];
        }
        if (cell == self.userInfoCell) {
            [self performSegueWithIdentifier:@"PresentUserInfoView" sender:nil];
        }
    }
    
}
- (void)presenLoginViewController{
    UIStoryboard *mainStoryboard =[UIStoryboard storyboardWithName:@"LoginPage" bundle:nil];
    LoginViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)presentLogOutAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"確定是否要登出？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         [[AuthorizedManager sharedInstance]logout];
                                                         [[AccountRepository sharedInstance]removeAccountInfo];
                                                         [self checkCurrentLoginStatus];
                                                         
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
@end
