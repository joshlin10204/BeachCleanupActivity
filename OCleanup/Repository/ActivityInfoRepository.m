//
//  ActivityInfoRepository.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/1.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityInfoRepository.h"

@import Firebase;

static ActivityInfoRepository *instance;
static dispatch_once_t onceToken;
@interface ActivityInfoRepository()
@property (strong, nonatomic) FIRDatabaseReference * databaseRef;
@property (strong, nonatomic) FIRStorageReference * storageRef;
@end

@implementation ActivityInfoRepository
+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.databaseRef =[[[FIRDatabase database] reference]child:@"activitys"];
        instance.storageRef =[[[FIRStorage storage] reference]child:@""];
        
    });
    return instance;
}

#pragma mark  -Activity Info Database

- (void)loadAllActivityInfo{
    
    
    [self.databaseRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *allInfo = snapshot.value;
        NSArray* allActivityInfoArray = [self sortAllActivityInfo:allInfo];
        [self.delegate loadAllActivityInfoDidFinish:allActivityInfoArray];
    }];
    
    
}

- (void)loadAccountInfoFromActivityID:(NSString*)activityId{
    
    [[self.databaseRef child:activityId] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *info = snapshot.value;
    }];
    
}

- (NSArray *)sortAllActivityInfo:(NSDictionary*)allInfo{
    
    NSMutableArray *keys =(NSMutableArray*)[allInfo allKeys];
    NSMutableArray *allActivityInfoArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = keys.count; i>0; i--) {
        NSDictionary *info = [allInfo objectForKey:keys[i-1]];
        ActivityInfoModel *model = [self getAllActivityInfoModelFromDictionary:info];
        [allActivityInfoArray addObject:model];
    }
    //依照 date 排序
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:ACTIVITY_INFO_DATABASE_DATE
                                                                     ascending:NO];
    NSArray *allActivityInfo = [allActivityInfoArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    return allActivityInfo;
}


- (ActivityInfoModel*)getAllActivityInfoModelFromDictionary:(NSDictionary*)dictionary{
    ActivityInfoModel *model = [[ActivityInfoModel alloc]init];
    model.activityId=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_ID];
    model.title=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_TITLE];
    model.subtitle=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_SUBTITLE];
    model.date=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_DATE];
    model.time=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_TIME];
    model.address=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_ADDRESS];
    model.latitude=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_LATITUDE];
    model.longitude=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_LONGITUDE];
    model.about=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_ABOUT];
    model.amount=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_AMOUNT];
    model.quota=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_QUOTA];
    model.fbId=[dictionary objectForKey:ACTIVITY_INFO_DATABASE_FACEBOOKID];
    model.imageUrl =[dictionary objectForKey:ACTIVITY_INFO_DATABASE_IMAGEURL];
//    NSString * url =[dictionary objectForKey:ACTIVITY_INFO_DATABASE_IMAGEURL];
//    model.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];

    return model;
}

#pragma mark  -Activity Image Storage

- (void)loadActivityImageFromActivityID:(NSString*)activityId{
    [[self.storageRef child:activityId]dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error ==nil) {
            UIImage *accountImage = [UIImage imageWithData:data];
        }
    }];
    
}



@end
