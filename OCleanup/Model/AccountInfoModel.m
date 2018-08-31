//
//  AccountInfoModel.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "AccountInfoModel.h"

@implementation AccountInfoModel

///???:在NSKeyedArchiver 時必須實現 NSCoding
-(instancetype)initWithCoder:(NSCoder *)coder
{
    // self = [super initWithCoder:coder];
    self = [super init];
    if (self) {
        self.accountId = [coder decodeObjectForKey:@"accountId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.phone = [coder decodeObjectForKey:@"phone"];
        self.photo = [coder decodeObjectForKey:@"photo"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.photo forKey:@"photo"];

}
@end
