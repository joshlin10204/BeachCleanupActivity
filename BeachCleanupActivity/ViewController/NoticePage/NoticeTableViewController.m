//
//  NoticeTableViewController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "NoticeTableViewController.h"
#import "NoticeTableViewCell.h"

#import "NoticeData.h"

static NSString *cellID = @"NoticeTableViewCell";

@interface NoticeTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NoticeData * noticeData;
    NSMutableArray *allNoticeArray;
    
}

@end

@implementation NoticeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNoticeData];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"NoticeTableViewCell"];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNoticeData{
    noticeData = [[NoticeData alloc]init];
    allNoticeArray = [noticeData getAllNoticeMessage];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return allNoticeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat cellHight = self.view.frame.size.height * 0.15;
    
    return cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSMutableDictionary * info = [allNoticeArray objectAtIndex:indexPath.row];
    cell.noticeTitleLabel.text = [info objectForKey:NOTICE_TITLE];
    cell.noticeMessageLabel.text = [info objectForKey:NOTICE_MESSAGE];
    cell.noticeImageView.image = [info objectForKey:NOTICE_IMAGE];
 
    return cell;
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
