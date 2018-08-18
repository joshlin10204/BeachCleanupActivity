//
//  NoticeTableViewCell.m
//  BeachCleanupActivity
//
//  Created by JoshLin on 2018/8/18.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initMessageLabel];
    [self.noticeMessageLabel sizeToFit];
    [self.noticeMessageLabel setNumberOfLines:0];

}

- (void)initMessageLabel{
//
//    CGFloat width = self.frame.size.width * 0.7;
//    CGFloat height = self.frame.size.height *0.4;
//    CGFloat x = self.frame.size.width * 0.25;
//    CGFloat y = self.frame.size.height * 0.5;
//    self.noticeMessageLabel = [[UILabel alloc]init];
//    CGSize maximumSize = CGSizeMake(300, 9999);
//    NSString *dateString = @"The date today is January 1st, 1999";
//    UIFont *dateFont = [UIFont fontWithName:@"Helvetica" size:14];
//    CGSize dateStringSize = [dateString sizeWithFont:dateFont
//                                   constrainedToSize:maximumSize
//                                       lineBreakMode:self.noticeMessageLabel.lineBreakMode];
//
//    CGRect dateFrame = CGRectMake(x, y, width, height);
//
//    self.noticeMessageLabel.frame = dateFrame;
//    self.noticeMessageLabel.text= dateString;
//    [self addSubview:self.noticeMessageLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    frame.origin.y += 1;      // 让cell的y值增加1(根据自己需要分割线的高度来进行调整)
    frame.size.height -= 1;   // 让cell的高度减1
    [super setFrame:frame];

}

@end
