//
//  BasicTabBar.m
//  OCleanup
//
//  Created by JoshLin on 2018/7/23.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "BasicTabBar.h"

@implementation BasicTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initHomePageBtn];
    [self initTabBarItems];
    
}

-(void)initHomePageBtn{
    if (self.homePageBtn ==nil) {
        
        CGFloat width = self.frame.size.width * 0.17;
        CGFloat height = width;
        CGFloat x = self.frame.size.width * 0.5;
        CGFloat y = self.frame.size.height * 0.1;
        
        
        
        self.homePageBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.homePageBtn setBackgroundImage:[UIImage imageNamed:@"Earth"] forState:UIControlStateNormal];
        [self.homePageBtn setBackgroundImage:[UIImage imageNamed:@"Earth"] forState:UIControlStateHighlighted];
        [self.homePageBtn sizeToFit];
        
        CGRect btnFrame = self.homePageBtn.frame;
        btnFrame.size = CGSizeMake(width,height);
        self.homePageBtn.frame = btnFrame;
        self.homePageBtn.center = CGPointMake(x, y);
        
        [self addSubview:self.homePageBtn];
        [self.homePageBtn addTarget:self
                             action:@selector(onClickCenterBtn:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)initTabBarItems{
    
    CGFloat buttonW = self.frame.size.width /5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    NSInteger index = 0;
    for (UIView  * button in self.subviews) {
        
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1): (index));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO) {
        //将当前tabbar的触摸点转换坐标系，转换到中间按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.homePageBtn];
        //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
        if ( [self.homePageBtn pointInside:newP withEvent:event]) {
            return self.homePageBtn;
        }
    }
    
    return [super hitTest:point withEvent:event];
    
}


-(void)onClickCenterBtn:(id)sender{
    NSLog(@"Click!!!");
    
}
@end
