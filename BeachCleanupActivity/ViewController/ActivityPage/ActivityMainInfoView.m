//
//  ActivityMainInfoView.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityMainInfoView.h"

@implementation ActivityMainInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ActivityMainInfoView" owner:self options:nil];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
    }
    
    return self;
}
-(void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude title:(NSString*)titleString address:(NSString*)address{
    
    [self.mapView locateToLatitude:latitude longitude:(CGFloat)longitude title:titleString address:address];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
