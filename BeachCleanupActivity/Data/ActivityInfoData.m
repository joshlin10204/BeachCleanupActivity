//
//  ActivityInfoData.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/2.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityInfoData.h"

@implementation ActivityInfoData

-(NSMutableArray * )getAllActivityInfo{
    
    NSMutableArray * allInfo = [[NSMutableArray alloc]init];
    NSMutableDictionary * testInfo = [self getTestActivityInfo];
    
    
    [allInfo addObject:testInfo];
    [allInfo addObject:testInfo];
    [allInfo addObject:testInfo];

    return allInfo;
    
}

-(NSMutableDictionary * )getTestActivityInfo{
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]init];
    
    UIImage *image = [UIImage imageNamed:@"TestActivityImage"];
    NSString *idString = @"1";
    NSString *titleString = @"五告熱";
    NSString *subtitleString = @"麟山鼻淨灘 X 衝浪";

    NSString *dateString = @"2018/05/26";
    NSString *timeString = @"14:00";
    NSString *locationString = @"麟山鼻";
    NSString *quotaString = @"50";

    NSString *detailString = @"5月26日，這是公曆一年中的第 146 天，離今年結束還有 219 天，我們將在五月底舉辦｜時代在走。愛地球要有｜的第五場 #淨灘！";
    [info setObject:image forKey:ACTIVITY_INFO_IMAGE];
    [info setObject:idString forKey:ACTIVITY_INFO_TITLE];
    [info setObject:titleString forKey:ACTIVITY_INFO_TITLE];
    [info setObject:subtitleString forKey:ACTIVITY_INFO_SUBTITLE];
    [info setObject:dateString forKey:ACTIVITY_INFO_DATE];
    [info setObject:timeString forKey:ACTIVITY_INFO_TIME];
    [info setObject:locationString forKey:ACTIVITY_INFO_LOCATION];
    [info setObject:detailString forKey:ACTIVITY_INFO_DETAIL];
    [info setObject:quotaString forKey:ACTIVITY_INFO_QUOTA];

    
    return info;
}
-(NSMutableDictionary * )getActivityInfoFormId:(NSString*) activityId{
    
    NSMutableDictionary * testInfo = [self getTestActivityInfo];
    
    return testInfo;

}

@end
