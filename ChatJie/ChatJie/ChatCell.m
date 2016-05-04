//
//  ChatCell.m
//  ChatJie
//
//  Created by 王 on 16/5/4.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell




//更改约束
- (void)changeConstraints
{
    _avaterImgViewHeight.constant = RYJGiveHeight(45);
    _avaterImgViewWidth.constant = RYJGiveHeight(45);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
