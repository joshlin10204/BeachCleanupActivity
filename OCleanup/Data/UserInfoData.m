//
//  UserInfoData.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "UserInfoData.h"

@implementation UserInfoData

- (NSMutableDictionary * )getUserInfo{
    
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc]init];
    
    NSString *idString = @"1";
    NSString *emailString = @"locking10204@gmail.com";
    NSString *nameString = @"Josh";
    NSString *phoneString = @"098765432";
    NSString *genderString = @"男";
    UIImage *image = [UIImage imageNamed:@"Earth"];
    
    
    [userInfo setObject:idString forKey:USERINFO_ID];
    [userInfo setObject:emailString forKey:USERINFO_EMAIL];
    [userInfo setObject:nameString forKey:USERINFO_NAME];
    [userInfo setObject:phoneString forKey:USERINFO_PHONE];
    [userInfo setObject:genderString forKey:USERINFO_GENDER];
    [userInfo setObject:image forKey:USERINFO_IMAGE];
    
    
    return userInfo;
    
}
@end
