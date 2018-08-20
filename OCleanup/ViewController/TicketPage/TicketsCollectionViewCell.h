//
//  TicketsCollectionViewCell.h
//  OCleanup
//
//  Created by JoshLin on 2018/8/15.
//  Copyright © 2018年 JoshLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *ticketTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ticketImageview;
@end
