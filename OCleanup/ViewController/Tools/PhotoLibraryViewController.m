//
//  PhotoLibraryViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/1.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "PhotoLibraryViewController.h"

static PhotoLibraryViewController *instance;
static dispatch_once_t onceToken;


@interface PhotoLibraryViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation PhotoLibraryViewController


+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)presentPhotoLibraryFromViewControler:(UIViewController*)viewControler{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.delegate = self;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [viewControler presentViewController:imagePickerVC animated:YES completion:nil];
    }else{
        [self.delegate photoLibraryDidCancel];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // dismiss UIImagePickerController
    // 选择的图片信息存储于info字典中
    NSLog(@"%@", info);
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
}

@end
