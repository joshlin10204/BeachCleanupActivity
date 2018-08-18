//
//  NoticeData.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "NoticeData.h"

@implementation NoticeData

- (NSMutableArray * )getAllNoticeMessage{
    
    NSMutableArray * allNotice = [[NSMutableArray alloc]init];
    NSMutableDictionary * testInfo = [self getTestNotice];
    
    
    [allNotice addObject:testInfo];
    [allNotice addObject:testInfo];
    [allNotice addObject:testInfo];
    
    
    return allNotice;
}

- (NSMutableDictionary * )getTestNotice{
    NSMutableDictionary * noticeInfo = [[NSMutableDictionary alloc]init];
    
    NSString *idString = @"1";
    NSString *titleString = @"活動通知";
    NSString *timeString = @"14:00";
    NSString *messageString = @"活動準備開始，請到報到處集合\n測試！！！\n測試！！！\n測試！！！";
    UIImage *image = [UIImage imageNamed:@"Earth"];

    
    [noticeInfo setObject:idString forKey:NOTICE_ID];
    [noticeInfo setObject:titleString forKey:NOTICE_TITLE];
    [noticeInfo setObject:timeString forKey:NOTICE_TIME];
    [noticeInfo setObject:messageString forKey:NOTICE_MESSAGE];
    [noticeInfo setObject:image forKey:NOTICE_IMAGE];

    
    return noticeInfo;
}

@end

