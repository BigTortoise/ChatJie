//
//  RYJPersonModel.h
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYJPersonModel : NSObject
/**
 *  用户头像
 */
@property (nonatomic,copy)NSString * avater;

/**
 *  用户昵称
 */
@property (nonatomic,copy)NSString * nickName;

/**
 *  微信号
 */
@property (nonatomic,copy)NSString * weID;
@end
