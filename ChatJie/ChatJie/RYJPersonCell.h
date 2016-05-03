//
//  RYJPersonCell.h
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RYJPersonModel;

@interface RYJPersonCell : UITableViewCell

//用户个人数据模型
@property(nonatomic,strong)RYJPersonModel *model;

/**
 *  用户头像ImgView
 */
@property (nonatomic,strong)UIImageView * avaterImgView;

/**
 *  用户名Label
 */
@property (nonatomic,strong)UILabel * userNameLabel;

/**
 *  微信号Label
 */
@property (nonatomic,strong)UILabel * weIDLabel;

/**
 *  二维码ImgView
 */
@property (nonatomic,strong)UIImageView * wmImgView;
- (void)setModel:(RYJPersonModel *)model;
@end
