//
//  TicketInfoModel.m
//  OCleanup
//
//  Created by JoshLin on 2018/10/6.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketInfoModel.h"

@implementation TicketInfoModel
///???:在NSKeyedArchiver 時必須實現 NSCoding
-(instancetype)initWithCoder:(NSCoder *)coder
{
    // self = [super initWithCoder:coder];
    self = [super init];
    if (self) {
        self.activityId = [coder decodeObjectForKey:@"activityId"];
        self.ticketId = [coder decodeObjectForKey:@"ticketId"];
        self.accountId = [coder decodeObjectForKey:@"accountId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.phone = [coder decodeObjectForKey:@"phone"];
        self.type = [coder decodeObjectForKey:@"type"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.activityId forKey:@"activityId"];
    [aCoder encodeObject:self.ticketId forKey:@"ticketId"];
    [aCoder encodeObject:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.type forKey:@"type"];

}
@end
