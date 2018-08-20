//
//  NoticeData.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NOTICE_ID @"noticeID"
#define NOTICE_TITLE @"noticeTitle"
#define NOTICE_TIME @"noticeTime"
#define NOTICE_MESSAGE @"noticetMessage"
#define NOTICE_IMAGE @"noticetImage"

@interface NoticeData : NSObject
- (NSMutableArray * )getAllNoticeMessage;
@end
