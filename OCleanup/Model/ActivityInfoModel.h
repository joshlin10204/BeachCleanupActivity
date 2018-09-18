//
//  ActivityInfoModel.h
//  OCleanup
//
//  Created by JoshLin on 2018/9/2.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityInfoModel : NSObject
@property (nonatomic,strong) NSString *activityId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subtitle;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *about;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *quota;
@property (nonatomic,strong) NSString *fbId;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) UIImage *image;

@end
