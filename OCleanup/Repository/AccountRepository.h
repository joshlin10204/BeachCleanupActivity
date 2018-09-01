//
//  AccountRepository.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfoModel.h"

@interface AccountRepository : NSObject

+ (instancetype)sharedInstance;

- (void)loadAccountInfoFromAccountID:(NSString*)accountId;

- (void)loadAccountImageFromAccountID:(NSString*)accountId;

- (AccountInfoModel*)getAccountInfo;

- (void)updateAccountInfo:(AccountInfoModel*)accountInfo;

- (void)removeAccountInfo;



@end
