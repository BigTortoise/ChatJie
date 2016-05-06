//
//  RYJQuanCell.h
//  ChatJie
//
//  Created by 王 on 16/5/6.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuanModel.h"
@interface RYJQuanCell : UITableViewCell

@property(nonatomic,strong)QuanModel *model;

-(void)setModel:(QuanModel *)model;

@end
