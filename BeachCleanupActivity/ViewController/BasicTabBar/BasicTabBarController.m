//
//  BasicTabBarController.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/7/23.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "BasicTabBarController.h"
#import "BasicTabBar.h"
#import "ActivityCollectionViewController.h"
#import "TicketsCollectionViewController.h"
#import "HomeViewController.h"
#import "NoticeTableViewController.h"
#import "UserInfoViewController.h"
@interface BasicTabBarController (){
    
    BasicTabBar * basicTabBar;
    ActivityCollectionViewController * activityCollectionViewController;
    TicketsCollectionViewController * ticketsCollectionViewController;
    HomeViewController * homeViewController;
    NoticeTableViewController * noticeTableViewController;
    UserInfoViewController * userInfoViewController;
}

@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    activityCollectionViewController = [[ActivityCollectionViewController alloc]init];
    ticketsCollectionViewController = [[TicketsCollectionViewController alloc]init];
    homeViewController = [[HomeViewController alloc]init];
    noticeTableViewController = [[NoticeTableViewController alloc]init];
    userInfoViewController = [[UserInfoViewController alloc]init];
    

    
    [self setupChildVc:activityCollectionViewController
                 title:@"Activity"
                 image:@"TabBarItem_Activity_Unselected"
         selectedImage:@"TabBarItem_Activity_Selected"];
    [self setupChildVc:ticketsCollectionViewController
                 title:@"Tickets"
                 image:@"TabBarItem_Ticket_Unselected"
         selectedImage:@"TabBarItem_Ticket_Selected"];
    [self setupChildVc:noticeTableViewController
                 title:@"Notice"
                 image:@"TabBarItem_Notice_Unselected"
         selectedImage:@"TabBarItem_Notice_Selected"];
    [self setupChildVc:userInfoViewController
                 title:@"UserInfo"
                 image:@"TabBarItem_UserInfo_Unselected"
         selectedImage:@"TabBarItem_UserInfo_Selected"];
    
    
    basicTabBar = [[BasicTabBar alloc]init];
    [self setValue:basicTabBar forKey:@"tabBar"];
    CALayer *layer=[self createMaskLayer];
    [self.tabBar.layer addSublayer:layer];
    
    

}

-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
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
