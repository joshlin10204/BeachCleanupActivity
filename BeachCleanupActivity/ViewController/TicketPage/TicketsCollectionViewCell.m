//
//  TicketsCollectionViewCell.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/15.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "TicketsCollectionViewCell.h"

@interface TicketsCollectionViewCell(){
    CGPoint rightCircleCenter ;
    CGPoint leftCircleCenter ;
}
@end

@implementation TicketsCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TicketsCollectionViewCell" owner:self options:nil];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
        [self initContentVieLayerwMask];

    }
    
    return self;
}


- (void)initContentVieLayerwMask{

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:15];
    
    //左右兩邊半圓缺角
    rightCircleCenter.x = self.frame.size.width;
    rightCircleCenter.y = self.frame.size.height *0.63;
    leftCircleCenter.x = 0;
    leftCircleCenter.y = self.frame.size.height*0.63;
    CGFloat radius = self.frame.size.width * 0.06;
    
    //右邊半圓
    [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:rightCircleCenter
                                                     radius:radius
                                                 startAngle:M_PI_2
                                                   endAngle:M_PI+M_PI_2
                                                  clockwise:YES]];

    //左邊半圓
    [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:leftCircleCenter
                                                     radius:radius
                                                 startAngle:M_PI_2
                                                   endAngle:M_PI+M_PI_2
                                                  clockwise:NO]];
    //中間虛線
    CGFloat dashLength = self.frame.size.width - radius*2;
    CGFloat dashRadius = dashLength * 0.005;
    CGFloat dashCount = (dashLength /(dashRadius*2))/2;
    CGFloat dashBeginX = leftCircleCenter.x + radius;
    for (int i=1; i<dashCount; i++) {
        CGPoint dashCenter;
        dashCenter.x = dashBeginX+ dashRadius*4*i;
        dashCenter.y = leftCircleCenter.y;

        [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:dashCenter
                                                         radius:dashRadius
                                                     startAngle:0
                                                       endAngle:M_PI*2
                                                      clockwise:NO]];
    }

    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    [shapeLayer setFillRule:kCAFillRuleEvenOdd];
    self.contentView.layer.mask = shapeLayer;


    
    
}

@end
