//
//  TicketsData.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/16.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketsData.h"

@implementation TicketsData
-(NSMutableArray * )getAllTickets{
    
    NSMutableArray * allTicket = [[NSMutableArray alloc]init];
    NSMutableDictionary * testInfo = [self getTestTicket];
    
    
    [allTicket addObject:testInfo];
    [allTicket addObject:testInfo];
    [allTicket addObject:testInfo];
    
    
    return allTicket;
}
-(NSMutableDictionary * )getTestTicket{
    NSMutableDictionary * tickeInfo = [[NSMutableDictionary alloc]init];
    
    UIImage *image = [UIImage imageNamed:@"TestActivityImage"];
    NSString *idString = @"1";
    NSString *titleString = @"五告熱";
    NSString *dateString = @"2018/05/26";
    NSString *timeString = @"14:00-16:30";
    NSString *locationString = @"252新北市三芝區德茂村下員坑";

    
    
    [tickeInfo setObject:image forKey:TICKET_IMAGE];
    [tickeInfo setObject:idString forKey:TICKET_ID];
    [tickeInfo setObject:titleString forKey:TICKET_TITLE];
    [tickeInfo setObject:dateString forKey:TICKET_DATE];
    [tickeInfo setObject:timeString forKey:TICKET_TIME];
    [tickeInfo setObject:locationString forKey:TICKET_LOCATION];
   
    
    return tickeInfo;
}


@end
