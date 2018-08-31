//
//  AccountRepository.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//


#import "AccountRepository.h"
@import Firebase;


static AccountRepository *instance;
static dispatch_once_t onceToken;

@interface AccountRepository()
@property (strong, nonatomic) FIRDatabaseReference * databaseRef;
@property (strong, nonatomic) FIRStorageReference * storageRef;

@end
@implementation AccountRepository


+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.databaseRef =[[[FIRDatabase database] reference]child:ACCOUNT_DATABASE];
        instance.storageRef =[[[FIRStorage storage] reference]child:ACCOUNT_IMAGE_STORAGE];

    });
    return instance;
}

- (void)updateAccountInfo:(AccountInfoModel*)accountInfo{
    
    [self setAccountInfoUserDefaults:accountInfo];
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    [info setObject:accountInfo.accountId forKey:ACCOUNT_DATABASE_KEY_ID];
    [info setObject:accountInfo.name forKey:ACCOUNT_DATABASE_KEY_NAME];
    [info setObject:accountInfo.email forKey:ACCOUNT_DATABASE_KEY_EMAIL];
    [info setObject:accountInfo.phone forKey:ACCOUNT_DATABASE_KEY_PHONE];
    NSDictionary* dictionary = [NSDictionary dictionaryWithDictionary:info];
    [self.databaseRef  updateChildValues:dictionary];
}



- (AccountInfoModel*)getAccountInfo{

    NSDictionary *info =[self getAccountInfoUserDefaults];
    AccountInfoModel *accountInfo = [[AccountInfoModel alloc]init];
    accountInfo.accountId = [info objectForKey:ACCOUNT_DATABASE_KEY_ID];
    accountInfo.email = [info objectForKey:ACCOUNT_DATABASE_KEY_EMAIL];
    accountInfo.name = [info objectForKey:ACCOUNT_DATABASE_KEY_NAME];
    accountInfo.phone = [info objectForKey:ACCOUNT_DATABASE_KEY_PHONE];
    accountInfo.photo =[self getAccountImageUserDefaults];
    
    
    return accountInfo;
}
- (void)removeAccountInfo{
    
    [self removeAccountInfoUserDefaults];
}
#pragma mark  -Account Info Database
- (void)loadAccountInfoFromAccountID:(NSString*)accountId{
    
    [[self.databaseRef child:accountId] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *info = snapshot.value;
        [self setAccountInfoUserDefaults:info];
    }];
    
}
- (void)uploadAccountInfo:(NSDictionary*)info withAccountID:(NSString*)accountId{
    [[self.databaseRef child:accountId]setValue:info];
}



#pragma mark  -Account Image Storage

- (void)loadAccountPhotoFromAccountID:(NSString*)accountId{
    [[self.storageRef child:accountId]dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error ==nil) {
            UIImage *accountImage = [UIImage imageWithData:data];
            [self setAccountImageUserDefaults:accountImage];
        }
    }];
    
}

- (void)uploadAccountPhoto:(UIImage*)image withAccountID:(NSString*)accountId{
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [[self.storageRef child:accountId] putData:imageData];
    
}


#pragma mark  -UserDefaults

- (void)setAccountInfoUserDefaults:(NSDictionary*)accountInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accountInfo forKey:ACCOUNT_USERDEFAULTS_KEY_INFO];
}

- (NSDictionary*)getAccountInfoUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *infoData = [defaults objectForKey:ACCOUNT_USERDEFAULTS_KEY_INFO];
    return infoData;
}
- (void)removeAccountInfoUserDefaults{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCOUNT_USERDEFAULTS_KEY_INFO];

}


- (void)setAccountImageUserDefaults:(UIImage*)image{
    NSData *imageData = UIImagePNGRepresentation(image) ;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imageData forKey:ACCOUNT_USERDEFAULTS_KEY_IMAGE];
}

- (UIImage*)getAccountImageUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* imageData = [defaults objectForKey:ACCOUNT_USERDEFAULTS_KEY_IMAGE];
    UIImage *image = [UIImage imageWithData:imageData];;
    return image;
}
@end
