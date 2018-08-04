//
//  ActivityInfoData.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/2.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ACTIVITY_INFO_ID @"activityInfoId"
#define ACTIVITY_INFO_IMAGE @"activityInfoImage"
#define ACTIVITY_INFO_TITLE @"activityInfoTitle"
#define ACTIVITY_INFO_SUBTITLE @"activityInfoSubtitle"
#define ACTIVITY_INFO_DATE @"activityInfoDate"
#define ACTIVITY_INFO_TIME @"activityInfoTime"
#define ACTIVITY_INFO_LOCATION @"activityInfoLocation"
#define ACTIVITY_INFO_DETAIL @"activityInfoDetail"
#define ACTIVITY_INFO_QUOTA @"activityInfoQuota"


@interface ActivityInfoData : NSObject
-(NSMutableArray * )getAllActivityInfo;
-(NSMutableDictionary * )getActivityInfoFormId:(NSString*) activityId;

@end


