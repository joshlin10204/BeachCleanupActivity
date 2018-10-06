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
@property (strong, nonatomic) AccountInfoModel *accountInfo;
@property (strong, nonatomic) NSUserDefaults *defaults;
@end
@implementation AccountRepository


+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.databaseRef =[[[FIRDatabase database] reference]child:ACCOUNT_DATABASE];
        instance.storageRef =[[[FIRStorage storage] reference]child:ACCOUNT_IMAGE_STORAGE];
        instance.accountInfo = [[AccountInfoModel alloc]init];
        instance.defaults = [NSUserDefaults standardUserDefaults];


    });
    return instance;
}

- (void)updateAccountInfo:(AccountInfoModel*)accountInfo{
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    [info setObject:accountInfo.accountId forKey:ACCOUNT_DATABASE_KEY_ID];
    [info setObject:accountInfo.name forKey:ACCOUNT_DATABASE_KEY_NAME];
    [info setObject:accountInfo.email forKey:ACCOUNT_DATABASE_KEY_EMAIL];
    [info setObject:accountInfo.phone forKey:ACCOUNT_DATABASE_KEY_PHONE];
    NSDictionary* dictionary = [NSDictionary dictionaryWithDictionary:info];
    [self setAccountInfoUserDefaults:dictionary];
    [self setAccountImageUserDefaults:accountInfo.image];
    [[self.databaseRef child:accountInfo.accountId]  updateChildValues:dictionary];
    [self uploadAccountPhoto:accountInfo.image withAccountID:accountInfo.accountId];
}



- (AccountInfoModel*)getAccountInfo{

    NSDictionary *info =[self getAccountInfoUserDefaults];
    self.accountInfo.accountId = [info objectForKey:ACCOUNT_DATABASE_KEY_ID];
    self.accountInfo.email = [info objectForKey:ACCOUNT_DATABASE_KEY_EMAIL];
    self.accountInfo.name = [info objectForKey:ACCOUNT_DATABASE_KEY_NAME];
    self.accountInfo.phone = [info objectForKey:ACCOUNT_DATABASE_KEY_PHONE];
    self.accountInfo.image =[self getAccountImageUserDefaults];
    
    
    return self.accountInfo;
}
- (void)removeAccountInfo{
    
    [self removeAccountInfoUserDefaults];
    [self removeAccountImageUserDefaults];
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

- (void)loadAccountImageFromAccountID:(NSString*)accountId{
    [[self.storageRef child:accountId]dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error ==nil) {
            UIImage *accountImage = [UIImage imageWithData:data];
            [self setAccountImageUserDefaults:accountImage];
        }
    }];
    
}

- (void)uploadAccountPhoto:(UIImage*)image withAccountID:(NSString*)accountId{
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.6) ;
    [[self.storageRef child:accountId] putData:imageData];
    
}


#pragma mark  -UserDefaults

- (void)setAccountInfoUserDefaults:(NSDictionary*)accountInfo{
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setObject:accountInfo forKey:ACCOUNT_USERDEFAULTS_KEY_INFO];
    
    
}

- (NSDictionary*)getAccountInfoUserDefaults{
    self.defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *infoData = [self.defaults objectForKey:ACCOUNT_USERDEFAULTS_KEY_INFO];
    return infoData;
}
- (void)removeAccountInfoUserDefaults{
    [self.defaults removeObjectForKey:ACCOUNT_USERDEFAULTS_KEY_INFO];
}
- (void)setAccountImageUserDefaults:(UIImage*)image{
    NSData *imageData = UIImageJPEGRepresentation(image,0.6) ;
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setObject:imageData forKey:ACCOUNT_USERDEFAULTS_KEY_IMAGE];
}

- (UIImage*)getAccountImageUserDefaults{
    self.defaults = [NSUserDefaults standardUserDefaults];
    NSData* imageData = [self.defaults objectForKey:ACCOUNT_USERDEFAULTS_KEY_IMAGE];
    UIImage *image = [UIImage imageWithData:imageData];;
    return image;
}
- (void)removeAccountImageUserDefaults{
    [self.defaults removeObjectForKey:ACCOUNT_USERDEFAULTS_KEY_IMAGE];
}

@end
