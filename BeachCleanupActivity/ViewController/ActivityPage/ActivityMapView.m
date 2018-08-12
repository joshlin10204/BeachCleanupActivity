//
//  ActivityMapView.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/12.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "ActivityMapView.h"

@interface ActivityMapView()<MKMapViewDelegate>{
    
}
@end
@implementation ActivityMapView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//
//    if (self) {
//        [[NSBundle mainBundle] loadNibNamed:@"ActivityMapView" owner:self options:nil];
//        self.contentView.frame = self.bounds;
//        [self addSubview:self.contentView];
//    }
//
//    return self;
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder

{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        UIView *containerView = [[[UINib nibWithNibName:@"ActivityMapView" bundle:nil] instantiateWithOwner:self options:nil] firstObject ];
        containerView.frame = self.bounds;
        [self addSubview:containerView];
        [self initMapView];

    }
    
    return self;
    
}

- (void)initMapView{
    
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;

    [self addSubview:self.mapView];
        self.mapView.scrollEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
 
//    [self locateToLatitude:23.126272 longitude:113.395568];
}

-(void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude title:(NSString*)titleString address:(NSString*)address{
    // 设置地图中心的经度、纬度
    CLLocationCoordinate2D center = {latitude,longitude};
    // 设置地图显示的范围，地图显示范围越小，细节越清楚
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005,0.005);
    // 创建MKCoordinateRegion对象，该对象代表地图的显示中心和显示范围
    MKCoordinateRegion region =MKCoordinateRegionMake(center, span);
    // 设置当前地图的显示中心和显示范围
    [self.mapView setRegion:region animated:YES];
    // 创建MKPointAnnotation对象——代表一个锚点
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.title = titleString;
    annotation.subtitle = address;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude , longitude);
    annotation.coordinate = coordinate;
    // 添加锚点
    [self.mapView addAnnotation:annotation];

}


@end
