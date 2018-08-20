//
//  ActivityInfoData.m
//  OCleanup
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
    NSString *timeString = @"14:00 - 16:30";
    NSString *locationString = @"252新北市三芝區德茂村下員坑";
    NSString *quotaString = @"50";
    NSString *amountString = @"免費";
//    NSString *longitude = @"121.5092011896021";
//    NSString *latitude = @"25.286574908120848";
    NSString *longitude = @"121.5133";
    NSString *latitude = @"25.2852";
    NSString *facebookId = @"362335367594223";



    NSString *detailString = @"『 鼻 ❤️ ，窩今天只想淨一淨 』\n05-26｜五告熱．麟山鼻淨灘\n▌淨灘報名連結：https://bit.ly/2wifoBp\n▌淨灘時間：2018.05.26（六）14:10 - 16:30\n▌交通方式：淡水捷運站 ⇒ 862/863 公車 ⇒ #北觀風景區管理處站\n▌集合時間＆地點：14:00 麟山鼻停車場\n--\n5月26日，這是公曆一年中的第 146 天，離今年結束還有 219 天，我們將在五月底舉辦｜時代在走。愛地球要有｜的第五場 #淨灘！\n地點要回到我們去年八月淨灘試驗場的初心地 - 北海岸石門區麟山鼻 。\n當時靠海巡大哥、店家以及所有淨灘人的極力幫忙，才能在近一年中逐漸形塑自覺自省也自醒的環保文化，一場接著一場\n對著我們起始點的麟山鼻，當天希望大家跟它說：鼻 ❤️ ，窩今天只想淨一淨\n誠懇溝通，就不會互生扞格\n一起來吧！";
    [info setObject:image forKey:ACTIVITY_INFO_IMAGE];
    [info setObject:idString forKey:ACTIVITY_INFO_TITLE];
    [info setObject:titleString forKey:ACTIVITY_INFO_TITLE];
    [info setObject:subtitleString forKey:ACTIVITY_INFO_SUBTITLE];
    [info setObject:dateString forKey:ACTIVITY_INFO_DATE];
    [info setObject:timeString forKey:ACTIVITY_INFO_TIME];
    [info setObject:locationString forKey:ACTIVITY_INFO_LOCATION];
    [info setObject:detailString forKey:ACTIVITY_INFO_ABOUT];
    [info setObject:quotaString forKey:ACTIVITY_INFO_QUOTA];
    [info setObject:amountString forKey:ACTIVITY_INFO_AMOUNT];
    [info setObject:longitude forKey:ACTIVITY_INFO_LONGITUDE];
    [info setObject:latitude forKey:ACTIVITY_INFO_LATITUDE];
    [info setObject:facebookId forKey:ACTIVITY_INFO_FACEBOOKID];




    
    return info;
}
-(NSMutableDictionary * )getActivityInfoFormId:(NSString*) activityId{
    
    NSMutableDictionary * testInfo = [self getTestActivityInfo];
    
    return testInfo;

}

@end
