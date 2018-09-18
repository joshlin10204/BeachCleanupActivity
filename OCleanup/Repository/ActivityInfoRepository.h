//
//  ActivityInfoRepository.h
//  OCleanup
//
//  Created by JoshLin on 2018/9/1.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityInfoModel.h"

#define ACTIVITY_INFO_DATABASE_ID @"activityId"
#define ACTIVITY_INFO_DATABASE_TITLE @"title"
#define ACTIVITY_INFO_DATABASE_SUBTITLE @"subtitle"
#define ACTIVITY_INFO_DATABASE_DATE @"date"
#define ACTIVITY_INFO_DATABASE_TIME @"time"
#define ACTIVITY_INFO_DATABASE_ADDRESS @"address"
#define ACTIVITY_INFO_DATABASE_LONGITUDE @"longitude"
#define ACTIVITY_INFO_DATABASE_LATITUDE @"latitude"
#define ACTIVITY_INFO_DATABASE_ABOUT @"about"
#define ACTIVITY_INFO_DATABASE_QUOTA @"quota"
#define ACTIVITY_INFO_DATABASE_AMOUNT @"amount"
#define ACTIVITY_INFO_DATABASE_FACEBOOKID @"fbId"
#define ACTIVITY_INFO_DATABASE_IMAGEURL @"imageUrl"


@protocol ActivityInfoRepositoryDelegate<NSObject>
@required
- (void)loadAllActivityInfoDidFinish:(NSArray*)allActivituInfo;
@end

@interface ActivityInfoRepository : NSObject
@property(nonatomic,weak) id <ActivityInfoRepositoryDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)loadAllActivityInfo;
@end
