//
//  TicketInspectionManager.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/28.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketInspectionManager.h"
#import "ActivityInfoRepository.h"

static TicketInspectionManager *instance;
static dispatch_once_t onceToken;

@import Firebase;
@interface TicketInspectionManager()
@property (strong, nonatomic) FIRDatabaseReference * googleTicketsDatabaseRef;
@property (strong, nonatomic) FIRDatabaseReference * appTicketsDatabaseRef;


@end
@implementation TicketInspectionManager

+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.googleTicketsDatabaseRef =[[[FIRDatabase database] reference]child:TICKET_GOOGLE_DATABASE];
        instance.appTicketsDatabaseRef =[[[FIRDatabase database] reference]child:TICKET_APP_DATABASE];
        
    });
    return instance;
}


- (void)inspectTicketJsonString:(NSString*)result{
    
    NSDictionary * info = [self dictionaryWithJsonString:result];
    NSNumber *ticketId = [info objectForKey:TICKET_INFO_ID_KEY];
    NSString *type = [info objectForKey:TICKET_INFO_TYPE_KEY];
    
    if ([type isEqualToString:TICKET_TYPE_APP]) {
        [self searchAppTicket:ticketId];
    }else if([type isEqualToString:TICKET_TYPE_GOOGLE]){
        [self searchGoogleTicket:ticketId];
    }else{
        [self.delegate inspectTicketDidFail:TicketInspectionError_TicketError];
    }
    
}

- (void)searchGoogleTicket:(NSNumber*)ticketId{
    NSString * ticketIdString=[[NSString alloc]initWithFormat:@"%@",ticketId];
    
    [[self.googleTicketsDatabaseRef child:ticketIdString] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *info = snapshot.value;
        if (![info isEqual:[NSNull null]]) {
            [self checkTikcetInfo:info];
            
        }else{
            [self.delegate inspectTicketDidFail:TicketInspectionError_NoJoin];
        }
    }];
    
    
}
- (void)searchAppTicket:(NSNumber*)ticketId{
    NSString * ticketIdString=[[NSString alloc]initWithFormat:@"%@",ticketId];
    [[self.appTicketsDatabaseRef child:ticketIdString] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *info = snapshot.value;
        if (![info isEqual:[NSNull null]]) {
            [self checkTikcetInfo:info];
        }else{
            [self.delegate inspectTicketDidFail:TicketInspectionError_NoJoin];
        }
    }];

    
}

- (void)checkTikcetInfo:(NSDictionary*)info{
    
    TicketInfoModel *ticketInfo = [self getTicketInfoModelFromDictionary:info];
    ActivityInfoModel *activityInfo = [[ActivityInfoRepository sharedInstance]getActivityInfoFromId:ticketInfo.activityId];
    NSString *activityDate = activityInfo.date;
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];

    if (![activityDate isEqualToString:currentDateString]) {
        [self.delegate inspectTicketDidFail:TicketInspectionError_NotYetStarted];
    }else{
        if (!ticketInfo.isPaid) {
            [self.delegate inspectTicketDidFail:TicketInspectionError_NotPaid];
        }else if (ticketInfo.isCheckIn){
            [self.delegate inspectTicketDidFail:TicketInspectionError_isCheckIn];
        }else{
            [self.delegate inspectTicketDidFinish:ticketInfo];
        }
    }
    

    
}


- (TicketInfoModel*)getTicketInfoModelFromDictionary:(NSDictionary*)info{
    
    TicketInfoModel *ticketInfo = [[TicketInfoModel alloc]init];
    ticketInfo.ticketId = [info objectForKey:TICKET_DATABASE_KEY_ID];
    ticketInfo.activityId = [info objectForKey:TICKET_DATABASE_KEY_ACTIVITY_ID];
    ticketInfo.accountId = [info objectForKey:TICKET_DATABASE_KEY_ACCOUNT_ID];
    ticketInfo.name = [info objectForKey:TICKET_DATABASE_KEY_NAME];
    ticketInfo.email = [info objectForKey:TICKET_DATABASE_KEY_EMAIL];
    ticketInfo.phone = [info objectForKey:TICKET_DATABASE_KEY_PHONE];
    ticketInfo.isCheckIn = [[info objectForKey:TICKET_DATABASE_KEY_CHECKIN]boolValue];
    ticketInfo.isPaid = [[info objectForKey:TICKET_DATABASE_KEY_PAID]boolValue];
    ticketInfo.type = [info objectForKey:TICKET_DATABASE_KEY_TYPE];

    return ticketInfo;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        [self.delegate inspectTicketDidFail:TicketInspectionError_TicketError];
        return nil;
    }
    return dic;
}
@end
