//
//  BasicTabBarController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/23.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "BasicTabBarController.h"
#import "BasicTabBar.h"
#import "ActivityViewController.h"
#import "TicketsViewController.h"
#import "HomeViewController.h"
#import "NoticeViewController.h"
#import "UserInfoViewController.h"

@interface BasicTabBarController (){
    
    BasicTabBar * basicTabBar;
    ActivityViewController * activityViewController;
    TicketsViewController * ticketsViewController;
    HomeViewController * homeViewController;
    NoticeViewController * noticeViewController;
    UserInfoViewController * userInfoViewController;
}

@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    activityViewController = [[ActivityViewController alloc]init];
    ticketsViewController = [[TicketsViewController alloc]init];
    homeViewController = [[HomeViewController alloc]init];
    noticeViewController = [[NoticeViewController alloc]init];
    userInfoViewController = [[UserInfoViewController alloc]init];
    
    
    [self setupChildVc:activityViewController
                 title:@"Activity"
                 image:@"TabBarItem_Activity_OffClick"
         selectedImage:@"TabBarItem_Activity_OnClick"];
    [self setupChildVc:ticketsViewController
                 title:@"Tickets"
                 image:@"TabBarItem_Ticket_OffClick"
         selectedImage:@"TabBarItem_Ticket_OnClick"];
    [self setupChildVc:noticeViewController
                 title:@"Notice"
                 image:@"TabBarItem_Notice_OffClick"
         selectedImage:@"TabBarItem_Notice_OnClick"];
    [self setupChildVc:userInfoViewController
                 title:@"UserInfo"
                 image:@"TabBarItem_UserInfo_OffClick"
         selectedImage:@"TabBarItem_UserInfo_OnClick"];
    
    
    basicTabBar = [[BasicTabBar alloc]init];
    [self setValue:basicTabBar forKey:@"tabBar"];
    CALayer *layer=[self createMaskLayer];
    [self.tabBar.layer addSublayer:layer];
    
    

}

-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navVc];
}

- (CAShapeLayer *)createMaskLayer{
    CGFloat width = self.tabBar.frame.size.width;
    CGFloat height = self.tabBar.frame.size.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    CGPoint point1 = CGPointMake(0, 0);//左上
    CGPoint point2 = CGPointMake(width * 0.3 , 0);//左弧形 begin
    CGPoint point3 = CGPointMake(width * 0.34 , 0);//左弧形 control
    CGPoint point4 = CGPointMake(width * 0.38 , -height * 0.3);//左弧形 end

    CGPoint point5 = CGPointMake(width * 0.5 , -height * 1.3);

    CGPoint point6 = CGPointMake(width * 0.62 , -height * 0.3);//右弧形 begin
    CGPoint point7 = CGPointMake(width * 0.66 , 0);//右弧形 control
    CGPoint point8 = CGPointMake(width * 0.7 , 0);//右弧形 end

    
    CGPoint point9 = CGPointMake(width , 0);//右上
    CGPoint point10 = CGPointMake(width, height);//右下
    CGPoint point11 = CGPointMake(0, self.tabBar.frame.size.height);//左下
    [path moveToPoint:point1];//建立起点
    [path addLineToPoint:point2];//畫線
    [path addQuadCurveToPoint:point4 controlPoint:point3];
    [path addQuadCurveToPoint:point6 controlPoint:point5];
    [path addQuadCurveToPoint:point8 controlPoint:point7];
    [path addLineToPoint:point9];
    [path addLineToPoint:point10];
    [path addLineToPoint:point11];
    [path closePath];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = path.CGPath;
    layer.shadowOpacity = 0.4;
    layer.shadowColor = [[UIColor colorWithRed:(150.0f / 255.0f) green:(150.0f/255.0f) blue:(150.0f/255.0f) alpha:1]CGColor];
    return layer;
}
@end
