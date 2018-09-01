//
//  PhotoLibraryViewController.h
//  OCleanup
//
//  Created by JoshLin on 2018/9/1.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhotoLibraryDelegate<NSObject>
@optional
- (void)photoLibraryDidFinish:(UIImage*)image;
- (void)photoLibraryDidCancel;
@end

@interface PhotoLibraryViewController : UIImagePickerController
@property (nonatomic, weak) id <PhotoLibraryDelegate> delegate;
+ (instancetype)sharedInstance;

@end
