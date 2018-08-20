//
//  UserInfoTableViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/20.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoPictureTableViewCell.h"
#import "UserInfoDetailTableViewCell.h"

#import "UserInfoData.h"

static NSString *detailCelllID = @"UserInfoDetailTableViewCell";
static NSString *pictureCellID = @"UserInfoPictureTableViewCell";

@interface UserInfoTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableDictionary *userInfo;
}

@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1];

    [self initUserInfo];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoDetailTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"UserInfoDetailTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoPictureTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"UserInfoPictureTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initUserInfo{
    UserInfoData * userInfoData = [[UserInfoData alloc]init];
    userInfo = [userInfoData getUserInfo];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return userInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHight;
    if (indexPath.section ==0) {
        cellHight = self.view.frame.size.height * 0.2;
    }else{
        cellHight = self.view.frame.size.height * 0.12;
        
    }
    
    return cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoDetailTableViewCell *detailCelll = [tableView dequeueReusableCellWithIdentifier:detailCelllID];
    UserInfoPictureTableViewCell *pictureCell = [tableView dequeueReusableCellWithIdentifier:pictureCellID];
    switch (indexPath.section) {
        case 0:
            pictureCell.infoImage.image = [userInfo objectForKey:USERINFO_IMAGE];
            return pictureCell;
        case 1:
            detailCelll.infotitleLabel.text = @"E-Mail";
            detailCelll.infoContentLabel.text = [userInfo objectForKey:USERINFO_EMAIL];

            return detailCelll;
        case 2:
            detailCelll.infotitleLabel.text = @"姓名";
            detailCelll.infoContentLabel.text = [userInfo objectForKey:USERINFO_NAME];
            
            return detailCelll;

        case 3:
            detailCelll.infotitleLabel.text = @"電話";
            detailCelll.infoContentLabel.text = [userInfo objectForKey:USERINFO_PHONE];
            
            return detailCelll;

        case 4:
            detailCelll.infotitleLabel.text = @"性別";
            detailCelll.infoContentLabel.text = [userInfo objectForKey:USERINFO_GENDER];
            
            return detailCelll;


        default:
            return detailCelll;
    }

    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
