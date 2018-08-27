//
//  AccountRepository.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//


#import "AccountRepository.h"

#define ACCOUNT_REPOSITORY_USER_INFO @"accountInfo"
static AccountRepository *instance;
static dispatch_once_t onceToken;

@interface AccountRepository()
@end
@implementation AccountRepository


+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)setAccountInfo:(AccountInfoModel*)accountInfo{
    NSData *InfoData = [NSKeyedArchiver archivedDataWithRootObject:accountInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:InfoData forKey:ACCOUNT_REPOSITORY_USER_INFO];
}

- (AccountInfoModel*)getAccountInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *infoData = [defaults objectForKey:ACCOUNT_REPOSITORY_USER_INFO];
    AccountInfoModel * accountInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:infoData];
    return accountInfoModel;
}
- (void)removeAccountInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCOUNT_REPOSITORY_USER_INFO];
}
@end
