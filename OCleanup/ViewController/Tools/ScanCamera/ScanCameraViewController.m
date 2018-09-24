//
//  ScanCameraViewController.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/22.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ScanCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic, strong) AVCaptureDevice *basicView;;
@property(nonatomic, strong) AVCaptureDevice *device;
@property(nonatomic, strong) AVCaptureDeviceInput *input;
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic, strong) UIView *scanLine;
@property(nonatomic, strong) UILabel *promptLabel;
@property(nonatomic, assign) CGRect scanRect;

@end

@implementation ScanCameraViewController
-(AVCaptureDevice *)device{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

-(AVCaptureDeviceInput *)input{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return  _input;
}

-(AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return  _output;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSession];
    [self initPreviewLayer];
    [self initSacnRact];
    [self initSacnRectFrame];
    [self initSacnRectFrameImage];
    [self initScanLine];
    [self initPromptLabel];
    [self setupMetadataOutput];
    [self.tabBarController.tabBar setHidden:YES];
    [self scanLinAnimationStart];

    ///MARK: startRunning 不能放在main thread，以免畫面卡死
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.session startRunning];

    });
    

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"在這設定畫面 可解決 開啟起熱點時偏移問題");


    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)initSession{
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    if([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
}

- (void)initPreviewLayer{
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];

    
}
- (void)initSacnRact{
    CGFloat width = self.view.frame.size.width*0.9;
    CGFloat height = width;
    CGFloat x = self.view.frame.size.width/2 - width/2;
    CGFloat y = self.view.frame.size.height * 0.2;
    self.scanRect = CGRectMake(x, y, width, height);

}
- (void)initSacnRectFrame{
    UIView *view =[[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
    CAShapeLayer* frameLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, view.bounds);
    CGPathAddRect(path, nil, self.scanRect);
    [frameLayer setFillRule:kCAFillRuleEvenOdd];
    [frameLayer setPath:path];
    [frameLayer setFillColor:[[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.8] CGColor]];
    [self.view.layer insertSublayer:frameLayer above:self.previewLayer];
  
}
- (void)initSacnRectFrameImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.scanRect];
    imageView.image=[UIImage imageNamed:@"ScanCameraView_ScanFrame"];
    [self.view addSubview:imageView];
}

- (void)setupMetadataOutput{
    CGFloat width = self.scanRect.size.width/[UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.scanRect.size.height/[UIScreen mainScreen].bounds.size.height;
    CGFloat x = self.scanRect.origin.x/[UIScreen mainScreen].bounds.size.width;
    CGFloat y = self.scanRect.origin.y/[UIScreen mainScreen].bounds.size.height;
    CGRect scanRectTransformed = CGRectMake(y, x, height, width);
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    self.output.rectOfInterest = scanRectTransformed;
}

- (void)initScanLine{
    CGFloat x = self.scanRect.origin.x;
    CGFloat y = self.scanRect.origin.y;
    CGFloat width = self.scanRect.size.width;
    CGFloat height = self.scanRect.size.height*0.01;
    self.scanLine = [[UIView alloc]initWithFrame:CGRectMake(x,y,width,height)];
    self.scanLine.backgroundColor = [UIColor colorWithRed:(125.0f/255.0f) green:(211.0f/255.0f) blue:(33.0f/255.0f) alpha:0.5];
    [self.view addSubview:self.scanLine];


    
}
- (void)scanLinAnimationStart{
    CGFloat movePointY=self.scanRect.size.height - self.scanLine.frame.size.height;
    [UIView animateWithDuration:3.0 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        [UIView setAnimationRepeatAutoreverses:YES];
        self.scanLine.transform = CGAffineTransformMakeTranslation(0, movePointY);
    } completion:^(BOOL finished) {
        self.scanLine.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
}
- (void)scanLinAnimationPause{
    CFTimeInterval pauseTime = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.view.layer.speed = 0;
    self.view.layer.timeOffset = pauseTime;
}
- (void)scanLinAnimationContinue{
    CFTimeInterval pausedTime = self.view.layer.timeOffset;

    self.view.layer.speed = 1;
    self.view.layer.timeOffset = 0;
    self.view.layer.beginTime = 0;

    CFTimeInterval continueTime = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    CFTimeInterval timePause = continueTime - pausedTime;
    self.view.layer.beginTime = timePause;
}


- (void)initPromptLabel{

    CGFloat width = self.scanRect.size.width;
    CGFloat height = self.scanRect.size.height*0.1;
    CGFloat x = self.scanRect.origin.x;
    CGFloat y = self.scanRect.origin.y+self.scanRect.size.height ;
    
    self.promptLabel = [[UILabel alloc]initWithFrame: CGRectMake(x, y, width, height)];
    self.promptLabel.text =@"請將報名票券QRCode，放置掃描框中";
    self.promptLabel.font = [UIFont boldSystemFontOfSize:12];
    self.promptLabel.numberOfLines = 1;
    self.promptLabel.minimumScaleFactor = 12;
    self.promptLabel.adjustsFontSizeToFitWidth = YES;
    self.promptLabel.textColor = [UIColor whiteColor];
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.promptLabel];
    
    
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if(metadataObjects.count > 0 && metadataObjects != nil){
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects lastObject];
        NSString *result = metadataObject.stringValue;
        NSLog(@"掃描到資訊：%@",result);

        [self scanLinAnimationPause];
        [self presentScanAlert:result];


    }
}

- (void)presentScanAlert:(NSString*)info{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"掃描結果"
                                                                             message:info
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [self scanLinAnimationContinue];
                                                         [self.session startRunning];

                                                         
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
