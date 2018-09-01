//
//  AccountInfoModel.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#define ACCOUNT_USERDEFAULTS_KEY_INFO @"accountInfo"
#define ACCOUNT_USERDEFAULTS_KEY_IMAGE @"accountImage"


#define ACCOUNT_IMAGE_STORAGE @"accountImages"
#define ACCOUNT_DATABASE @"accounts"
#define ACCOUNT_DATABASE_KEY_ID @"accountId"
#define ACCOUNT_DATABASE_KEY_EMAIL @"accountEmail"
#define ACCOUNT_DATABASE_KEY_NAME @"accountName"
#define ACCOUNT_DATABASE_KEY_PHONE @"accountPhone"
#define ACCOUNT_DATABASE_KEY_ISMANAGER @"accountisManager"



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AccountInfoModel : NSObject
@property (nonatomic,strong) NSString *accountId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) BOOL isManager;

@end
