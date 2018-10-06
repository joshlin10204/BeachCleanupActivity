//
//  LoadingView.m
//  OCleanup
//
//  Created by JoshLin on 2018/9/1.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView(){
    UIActivityIndicatorView * loadIndicatorView;
}
@end
@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.basicView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView"owner:self options:nil]objectAtIndex:0];
        //設定該xibView的Frame
        self.basicView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.basicView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //將xibView加入
        [self addSubview: self.basicView];
    }
    return self;
}

//#pragma mark ActivityIndicator
//- (void)initActivityIndicator{
//    loadIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
//    [loadIndicatorView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height*36/100)];
//    [loadIndicatorView setHidesWhenStopped:YES];
//    [loadIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [loadIndicatorView setColor:[UIColor grayColor]];
//    [self addSubview:loadIndicatorView];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
