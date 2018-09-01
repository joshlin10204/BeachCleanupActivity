//
//  UserInfoTableViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/20.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "AccountInfoTableViewController.h"
#import "AccountImageTableViewCell.h"
#import "AccountInfoDetailTableViewCell.h"
#import "AccountRepository.h"

static NSString *detailCelllID = @"AccountInfoDetailTableViewCell";
static NSString *imageCellID = @"AccountImageTableViewCell";
@interface AccountInfoTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    AccountInfoModel *accountInfo;
    NSInteger selectSection;
    UIImagePickerController * imagePickerViewController;
}

@end

@implementation AccountInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAccountInfo];
    [self initImagePickerViewController];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1];

    [self.tableView registerNib:[UINib nibWithNibName:@"AccountInfoDetailTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"AccountInfoDetailTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountImageTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"AccountImageTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loadAccountInfo{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        accountInfo = [[AccountRepository sharedInstance] getAccountInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
- (void)updateAccountInfo{
    [self.tableView reloadData];
    [[AccountRepository sharedInstance]updateAccountInfo:accountInfo];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHight;
    if (indexPath.section ==0) {
        cellHight = self.view.frame.size.height * 0.3;
    }else{
        cellHight = self.view.frame.size.height * 0.08;
        
    }
    
    return cellHight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.frame.size.height*0.03;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountInfoDetailTableViewCell *detailCelll = [tableView dequeueReusableCellWithIdentifier:detailCelllID];
    AccountImageTableViewCell *pictureCell = [tableView dequeueReusableCellWithIdentifier:imageCellID];
    pictureCell.selectionStyle =UITableViewCellSelectionStyleNone;
    detailCelll.selectionStyle =UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(onClickAccountImage)];
    tapRecognizer.numberOfTapsRequired = 1;
    [pictureCell.infoImage addGestureRecognizer:tapRecognizer];
    [pictureCell.infoImage setUserInteractionEnabled:YES];

    
    switch (indexPath.section) {
        case 0:
            pictureCell.infoImage.image = accountInfo.image;
            return pictureCell;
        case 1:
            detailCelll.infotitleLabel.text = @"E-Mail";
            detailCelll.infoContentLabel.text =accountInfo.email;
            detailCelll.accessoryType = UITableViewCellAccessoryNone;
            
            return detailCelll;
        case 2:
            detailCelll.infotitleLabel.text = @"姓名";
            detailCelll.infoContentLabel.text = accountInfo.name;
            
            return detailCelll;
            
        case 3:
            detailCelll.infotitleLabel.text = @"電話";
            detailCelll.infoContentLabel.text = accountInfo.phone;
            
            return detailCelll;
        default:
            return detailCelll;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectSection = indexPath.section;
    switch (indexPath.section) {
        case 2:
            [self presentEditAlertWithTitle:@"修改名字" withContent:accountInfo.name withKeyboardType:UIKeyboardTypeDefault];
            break;
        case 3:
            [self presentEditAlertWithTitle:@"修改電話" withContent:accountInfo.phone withKeyboardType:UIKeyboardTypePhonePad];
            break;
            
        default:
            break;
    }
    
    
}
- (void)onClickAccountImage{
    [self presentSelectImageSourceAlertSheet];
}

#pragma mark - AlertView

- (void)presentSelectImageSourceAlertSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoLibaryAction = [UIAlertAction actionWithTitle:@"開啟相簿"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [self presentPhotoLibraryView];
                                                                  
                                                              }];
    UIAlertAction *camaraAction = [UIAlertAction actionWithTitle:@"開啟相機"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                             [self presentCamaraView];
                                                         }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photoLibaryAction];
    [alertController addAction:camaraAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentEditAlertWithTitle:(NSString*)titleString withContent:(NSString*)content withKeyboardType:(UIKeyboardType)type{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:titleString
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = type;
        textField.text = content;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         UITextField *textField =alertController.textFields.firstObject;
                                                         if (selectSection==2) {
                                                             accountInfo.name=textField.text;
                                                         }
                                                         if (selectSection==3) {
                                                             accountInfo.phone=textField.text;
                                                         }
                                                         [self updateAccountInfo];

                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerController

- (void)initImagePickerViewController{
    imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
}

- (void)presentPhotoLibraryView{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        imagePickerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerViewController animated:YES completion:nil];
    }
}
- (void)presentCamaraView{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerViewController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePickerViewController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:imagePickerViewController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    accountInfo.image = image;
    [self updateAccountInfo];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
