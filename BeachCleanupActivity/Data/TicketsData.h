//
//  TicketsData.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/16.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TICKET_ID @"ticketID"
#define TICKET_IMAGE @"ticketImage"
#define TICKET_TITLE @"ticketTitle"
#define TICKET_DATE @"ticketDate"
#define TICKET_TIME @"ticketTime"
#define TICKET_LOCATION @"ticketLocation"

@interface TicketsData : NSObject
-(NSMutableArray * )getAllTickets;

@end
