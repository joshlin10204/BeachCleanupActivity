//
//  ActivityInfoModel.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/2.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityInfoModel.h"

@implementation ActivityInfoModel
///???:在NSKeyedArchiver 時必須實現 NSCoding
-(instancetype)initWithCoder:(NSCoder *)coder
{
    // self = [super initWithCoder:coder];
    self = [super init];
    if (self) {
        self.activityId = [coder decodeObjectForKey:@"activityId"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.subtitle = [coder decodeObjectForKey:@"subtitle"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.time = [coder decodeObjectForKey:@"time"];
        self.address = [coder decodeObjectForKey:@"address"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
        self.latitude = [coder decodeObjectForKey:@"latitude"];
        self.about = [coder decodeObjectForKey:@"about"];
        self.amount = [coder decodeObjectForKey:@"amount"];
        self.quota = [coder decodeObjectForKey:@"quota"];
        self.fbId = [coder decodeObjectForKey:@"fbId"];
        self.imageUrl = [coder decodeObjectForKey:@"imageUrl"];
        self.image = [coder decodeObjectForKey:@"image"];



    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.activityId forKey:@"activityId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.about forKey:@"about"];
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.quota forKey:@"quota"];
    [aCoder encodeObject:self.fbId forKey:@"fbId"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.image forKey:@"image"];
    
}
@end
