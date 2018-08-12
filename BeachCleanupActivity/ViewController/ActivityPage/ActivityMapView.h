//
//  ActivityMapView.h
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ActivityMapView : UIView
@property (strong, nonatomic)  MKMapView *mapView;

-(void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude title:(NSString*)titleString address:(NSString*)address;
@end
