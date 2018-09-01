//
//  UserInfoPictureTableViewCell.m
//  OCleanup
//
//  Created by JoshLin on 2018/8/21.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "AccountImageTableViewCell.h"

@implementation AccountImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    CGPoint center;
    center.x = self.infoImage.center.x;
    center.y = self.infoImage.center.y;
    CGFloat radius = self.infoImage.frame.size.width/2;
    UIBezierPath *bpath =[UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:M_PI*2
                                                     clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    self.contentView.layer.mask = shapeLayer;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
