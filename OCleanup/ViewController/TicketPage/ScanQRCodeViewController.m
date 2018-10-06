//
//  ScanQRCodeViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ScanCameraView.h"
#import "TicketInspectionManager.h"

@interface ScanQRCodeViewController ()<ScanCameraDelegate,TicketInspectionDelegate>{
    
    ScanCameraView * scanCameraView;
}

@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initScanCameraView];
    [self.tabBarController.tabBar setHidden:YES];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - Scan Camera View

- (void)initScanCameraView{
    scanCameraView = [[ScanCameraView alloc]initWithFrame:self.view.frame];
    [self.view addSubview: scanCameraView];
    scanCameraView.delegate = self;
    [scanCameraView scanStart];
    
}

#pragma mark  -- Scan CameraDelegate
- (void)scanQRCodeDidFinish:(NSString *)result{
    
    [[TicketInspectionManager sharedInstance]inspectTicketJsonString:result];
    [TicketInspectionManager sharedInstance].delegate =self;
}


#pragma mark  -- TicketInspectionDelegate

- (void)inspectTicketDidStart{
    
    
}
- (void)inspectTicketDidFail:(TicketInspectionError)error{
    NSString * errorString ;
    switch (error) {
        case TicketInspectionError_isCheckIn:
            errorString = @"已完成報到";
            break;
            
        case TicketInspectionError_NotPaid:
            errorString = @"尚未繳交報名費";
            break;
            
        case TicketInspectionError_NoJoin:
            errorString = @"未報名此活動";
            break;
            
        case TicketInspectionError_TicketError:
            errorString = @"無此票券";
            break;
            
        case TicketInspectionError_NotYetStarted:
            errorString = @"此票券活動尚未開始";
            break;
            
        default:
            break;
    }
    
    
    [self presentScanAlert:errorString ];
    
}
- (void)inspectTicketDidFinish:(TicketInfoModel *)ticketInfo{
    
    NSLog(@"成功報到：%@",ticketInfo.activityId);
    [self presentScanAlert:ticketInfo.name];

    
}






//測試
- (void)presentScanAlert:(NSString*)info{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"掃描結果"
                                                                             message:info
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [scanCameraView scanContinue];
                                                         
                                                         
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



@end
