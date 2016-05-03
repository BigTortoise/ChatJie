//
//  RYJPersonCell.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJPersonCell.h"
#import "RYJPersonModel.h"
@implementation RYJPersonCell

- (void)setModel:(RYJPersonModel *)model {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.avaterImgView.image = [UIImage imageNamed:model.avater];
    self.userNameLabel.text = model.nickName;
    self.weIDLabel.text = [NSString stringWithFormat:@"微信号：%@",model.weID];
    
    self.wmImgView.image = [UIImage imageNamed:@"me_wm"];
}

//懒加载
- (UIImageView *)avaterImgView
{
    if (!_avaterImgView)
    {
        _avaterImgView = ({
            
            UIImageView * avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(RYJGiveWidth(12), RYJGiveHeight(12), self.frame.size.height - 2*RYJGiveHeight(12), self.frame.size.height - 2*RYJGiveHeight(12))];
            
            avaterImgView.clipsToBounds = YES;
            
            //加点圆角
            avaterImgView.layer.cornerRadius = 3;
            
            avaterImgView;
        });
        [self addSubview:_avaterImgView];
    }
    return _avaterImgView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        _userNameLabel = ({
            
            UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2*RYJGiveHeight(12) + 2*RYJGiveWidth(12), RYJGiveHeight(19),RYJGiveWidth(160), RYJGiveHeight(22))];
            
            userNameLabel.font = [UIFont systemFontOfSize:15];
            
            userNameLabel;
        });
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UILabel *)weIDLabel
{
    if (!_weIDLabel)
    {
        _weIDLabel = ({
            
            UILabel * weIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2*RYJGiveHeight(12) + 2*RYJGiveWidth(12), _userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + RYJGiveHeight(5), RYJGiveWidth(160), RYJGiveHeight(20))];
            
            weIDLabel.font = [UIFont systemFontOfSize:12];
            
            weIDLabel;
        });
        [self addSubview:_weIDLabel];
    }
    return _weIDLabel;
}

- (UIImageView *)wmImgView
{
    if (!_wmImgView)
    {
        _wmImgView = ({
            
            UIImageView * wmImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - RYJGiveWidth(50),((self.frame.size.height - RYJGiveHeight(35/2.0))/2.0), RYJGiveWidth(35/2.0), RYJGiveWidth(35/2.0))];
            
            wmImgView;
        });
        [self addSubview:_wmImgView];
    }
    return _wmImgView;
}
@end

