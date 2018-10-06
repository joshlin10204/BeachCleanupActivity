//
//  TicketInfoModel.h
//  OCleanup
//
//  Created by JoshLin on 2018/10/6.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TICKET_GOOGLE_DATABASE @"googleTickets"
#define TICKET_APP_DATABASE @"tickets"
#define TICKET_DATABASE_KEY_ID @"ticketId"
#define TICKET_DATABASE_KEY_ACTIVITY_ID @"activityId"
#define TICKET_DATABASE_KEY_ACCOUNT_ID @"accountId"
#define TICKET_DATABASE_KEY_NAME @"name"
#define TICKET_DATABASE_KEY_EMAIL @"email"
#define TICKET_DATABASE_KEY_PHONE @"phone"
#define TICKET_DATABASE_KEY_CHECKIN @"isCheckIn"
#define TICKET_DATABASE_KEY_PAID @"isPaid"
#define TICKET_DATABASE_KEY_TYPE @"type"



@interface TicketInfoModel : NSObject
@property (nonatomic,strong) NSString *ticketId;
@property (nonatomic,strong) NSString *activityId;
@property (nonatomic,strong) NSString *accountId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) BOOL isCheckIn;
@property (nonatomic,assign) BOOL isPaid;
@property (nonatomic,strong) NSString *type;



@end
