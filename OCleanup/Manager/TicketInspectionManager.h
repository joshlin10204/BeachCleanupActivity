//
//  TicketInspectionManager.h
//  OCleanup
//
//  Created by JoshLin on 2018/9/28.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#define TICKET_INFO_ID_KEY @"ticketId"
#define TICKET_INFO_TYPE_KEY @"type"
#define TICKET_TYPE_APP @"app"
#define TICKET_TYPE_GOOGLE @"google"



#import <Foundation/Foundation.h>
#import "TicketInfoModel.h"

typedef enum : NSInteger {
    TicketInspectionError_TicketError= 0,
    TicketInspectionError_NoJoin ,
    TicketInspectionError_isCheckIn,
    TicketInspectionError_NotPaid,
    TicketInspectionError_NotYetStarted,

} TicketInspectionError;


@protocol TicketInspectionDelegate<NSObject>
@optional
- (void)inspectTicketDidStart;
- (void)inspectTicketDidFail:(TicketInspectionError)error;
- (void)inspectTicketDidFinish:(TicketInfoModel*)ticketInfo;
@end


@interface TicketInspectionManager : NSObject

@property (nonatomic, weak) id <TicketInspectionDelegate> delegate;

+ (instancetype)sharedInstance;


- (void)inspectTicketJsonString:(NSString*)result ;

@end
