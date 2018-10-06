//
//  ScanCameraView.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ScanCameraView.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanCameraView()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic, strong) AVCaptureDevice *basicView;;
@property(nonatomic, strong) AVCaptureDevice *device;
@property(nonatomic, strong) AVCaptureDeviceInput *input;
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic, strong) UIView *scanLine;
@property(nonatomic, strong) UILabel *promptLabel;
@property(nonatomic, assign) CGRect scanRect;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
@implementation ScanCameraView




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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSession];
        [self initPreviewLayer];
        [self initSacnRact];
        [self initSacnRectFrame];
        [self initSacnRectFrameImage];
        [self initScanLine];
        [self initPromptLabel];
        [self setupMetadataOutput];
        [self scanLineAnimationStart];
        [self initActivityIndicator];

        

    }
    return self;
}

- (void)scanStart{
    ///MARK: startRunning 不能放在main thread，以免畫面卡死
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.session startRunning];
        
    });
}
- (void)scanContinue{
    [self scanLineAnimationContinue];
    [self.activityIndicator stopAnimating];

    ///MARK: startRunning 不能放在main thread，以免畫面卡死
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.session startRunning];
    });
    
}

#pragma mark  - init


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
    self.previewLayer.frame = self.bounds;
    [self.layer insertSublayer:self.previewLayer atIndex:0];
    
    
}
- (void)initSacnRact{
    CGFloat width = self.frame.size.width*0.9;
    CGFloat height = width;
    CGFloat x = self.frame.size.width/2 - width/2;
    CGFloat y = self.frame.size.height * 0.2;
    self.scanRect = CGRectMake(x, y, width, height);
    
}
- (void)initSacnRectFrame{
    UIView *view =[[UIView alloc]initWithFrame:self.frame];
    [self addSubview:view];
    CAShapeLayer* frameLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, view.bounds);
    CGPathAddRect(path, nil, self.scanRect);
    [frameLayer setFillRule:kCAFillRuleEvenOdd];
    [frameLayer setPath:path];
    [frameLayer setFillColor:[[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.8] CGColor]];
    [self.layer insertSublayer:frameLayer above:self.previewLayer];
    
}
- (void)initSacnRectFrameImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.scanRect];
    imageView.image=[UIImage imageNamed:@"ScanCameraView_ScanFrame"];
    [self addSubview:imageView];
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
    [self addSubview:self.scanLine];
    
    
    
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
    [self addSubview:self.promptLabel];
    
}
- (void)initActivityIndicator{
    

    CGFloat x = self.center.x;
    CGFloat y = self.promptLabel.frame.origin.y+self.promptLabel.frame.size.height*2 ;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = CGPointMake(x, y);
    [self addSubview:self.activityIndicator];
}


#pragma mark  - Scan Line Animation

- (void)scanLineAnimationStart{
    CGFloat movePointY=self.scanRect.size.height - self.scanLine.frame.size.height;
    [UIView animateWithDuration:3.0 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        [UIView setAnimationRepeatAutoreverses:YES];
        self.scanLine.transform = CGAffineTransformMakeTranslation(0, movePointY);
    } completion:^(BOOL finished) {
        self.scanLine.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
}
- (void)scanLineAnimationPause{
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0;
    self.layer.timeOffset = pauseTime;
}
- (void)scanLineAnimationContinue{
    CFTimeInterval pausedTime = self.layer.timeOffset;
    
    self.layer.speed = 1;
    self.layer.timeOffset = 0;
    self.layer.beginTime = 0;
    
    CFTimeInterval continueTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    CFTimeInterval timePause = continueTime - pausedTime;
    self.layer.beginTime = timePause;
}


#pragma mark  - AVCaptureMetadataOutput

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if(metadataObjects.count > 0 && metadataObjects != nil){
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects lastObject];
        if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode] &&
            [metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]){
            NSString *result = [[metadataObject stringValue]copy];
            [self scanLineAnimationPause];
            [self.activityIndicator startAnimating];
            [self.delegate scanQRCodeDidFinish:result];
            
        }
            
           

        
    }
}


@end
