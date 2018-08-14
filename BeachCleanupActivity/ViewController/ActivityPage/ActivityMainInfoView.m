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
        [self initLocationLabelTouchEven];
        
    }
    
    return self;
}
- (void)initLocationLabelTouchEven{
    
    self.locationLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onCLickLocationLabel)];
    [self.locationLabel addGestureRecognizer:tapGesture];
}
- (void)onCLickLocationLabel{
    
    NSString *urlString;
    // 有安裝Google Map App
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        urlString = [[NSString alloc]initWithFormat:@"comgooglemaps://?q=%@,%@",self.latitudeString,self.longitudeString];
    } else {
        urlString = [[NSString alloc]initWithFormat:@"http://maps.apple.com/?q=%@,%@&z=20",self.latitudeString,self.longitudeString];

    }
    [self openApplicationUrl:urlString];
}
- (IBAction)onClickFacebookBtn:(id)sender {
    
    NSString *urlString;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
         urlString =[[NSString alloc]initWithFormat:@"fb://profile/%@",self.facebookID];

    }else{
        urlString =[[NSString alloc]initWithFormat:@"https://www.facebook.com/events/%@",self.facebookID];
    }
    [self openApplicationUrl:urlString];


}

- (void)openApplicationUrl:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication]openURL:url
                                      options:@{}
                            completionHandler:nil];
    
}
@end
