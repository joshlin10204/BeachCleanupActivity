//
//  UserInfoData.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define USERINFO_ID @"userInfoId"
#define USERINFO_NAME @"userInfoName"
#define USERINFO_PHONE @"userInfoPhone"
#define USERINFO_EMAIL @"userInfoEamil"
#define USERINFO_GENDER @"userInfoGender"
#define USERINFO_IMAGE @"userInfoGenderImage"
@interface UserInfoData : NSObject

- (NSMutableDictionary * )getUserInfo;

@end
