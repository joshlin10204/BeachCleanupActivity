//
//  ActivityMainInfoView.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityMapView.h"

@interface ActivityMainInfoView : UIView

@property (strong, nonatomic) IBOutlet ActivityMainInfoView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *quotaLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet ActivityMapView *mapView;

-(void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude title:(NSString*)titleString address:(NSString*)address;


@end
