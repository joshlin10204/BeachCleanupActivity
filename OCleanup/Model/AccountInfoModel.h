//
//  AccountInfoModel.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/26.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AccountInfoModel : NSObject
@property (nonatomic,strong) NSString *accountId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *phone;
@end
