//
//  ScanCameraView.h
//  OCleanup
//
//  Created by JoshLin on 2018/9/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanCameraDelegate<NSObject>
@required
- (void)scanQRCodeDidFinish:(NSString *)result;
@end
@interface ScanCameraView : UIView
@property (nonatomic, weak) id <ScanCameraDelegate> delegate;

- (void) scanStart;
- (void) scanContinue;

@end
