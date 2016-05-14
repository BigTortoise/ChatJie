//
//  ChatCell.h
//  ChatJie
//
//  Created by 王 on 16/5/4.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avaterImgView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *avaterImgViewHeight;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *avaterImgViewWidth;

@end
