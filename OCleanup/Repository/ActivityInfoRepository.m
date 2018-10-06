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
@property (strong, nonatomic) NSUserDefaults *defaults;

@end

@implementation ActivityInfoRepository
+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.databaseRef =[[[FIRDatabase database] reference]child:@"activitys"];
        instance.storageRef =[[[FIRStorage storage] reference]child:@""];
        instance.defaults = [NSUserDefaults standardUserDefaults];
    });
    return instance;
}

#pragma mark  -Activity Info Database

- (void)loadAllActivityInfo{
    
    
    [self.databaseRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *allInfo = snapshot.value;
        NSArray* allActivityInfoArray = [self sortAllActivityInfo:allInfo];
        [self setAllActivityInfoUserDefaults:allInfo];
        [self.delegate loadAllActivityInfoDidFinish:allActivityInfoArray];
    }];
    
    
}

- (ActivityInfoModel*)getActivityInfoFromId:(NSString*)activityId{

    NSDictionary *allActivityInfo = [self getAllActivityInfoUserDefaults];
    NSDictionary *activityInfo = [allActivityInfo objectForKey:activityId];
    ActivityInfoModel *model = [self getActivityInfoModelFromDictionary:activityInfo];
    return model;
}

- (NSArray *)sortAllActivityInfo:(NSDictionary*)allInfo{
    
    NSMutableArray *keys =(NSMutableArray*)[allInfo allKeys];
    NSMutableArray *allActivityInfoArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = keys.count; i>0; i--) {
        NSDictionary *info = [allInfo objectForKey:keys[i-1]];
        ActivityInfoModel *model = [self getActivityInfoModelFromDictionary:info];
        [allActivityInfoArray addObject:model];
    }
    //依照 date 排序
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:ACTIVITY_INFO_DATABASE_DATE
                                                                     ascending:NO];
    NSArray *allActivityInfo = [allActivityInfoArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    return allActivityInfo;
}


- (ActivityInfoModel*)getActivityInfoModelFromDictionary:(NSDictionary*)dictionary{
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



#pragma mark  -UserDefaults

- (void)setAllActivityInfoUserDefaults:(NSDictionary*)allActivityInfo{
    NSData *allActivityInfoData = [NSKeyedArchiver archivedDataWithRootObject:allActivityInfo];
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setObject:allActivityInfoData forKey:ACTIVITY_USERDEFAULTS_KEY_ALL_INFO];
}

- (NSDictionary*)getAllActivityInfoUserDefaults{
    self.defaults = [NSUserDefaults standardUserDefaults];
    NSData *allActivityInfoData = [self.defaults objectForKey:ACTIVITY_USERDEFAULTS_KEY_ALL_INFO];
    NSDictionary *allActivityInfo = [NSKeyedUnarchiver unarchiveObjectWithData:allActivityInfoData];
    return allActivityInfo;
    

}






#pragma mark  -NOT USE Activity Image Storage

- (void)loadActivityImageFromActivityID:(NSString*)activityId{
    [[self.storageRef child:activityId]dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error ==nil) {
            UIImage *accountImage = [UIImage imageWithData:data];
        }
    }];
    
}



@end
