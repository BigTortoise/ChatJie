//
//  RYJChatModel.h
//  ChatJie
//
//  Created by 王 on 16/5/4.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYJChatModel : NSObject

/**
 *  头像
 */
@property (nonatomic,copy)NSString * avatar;

/**
 *  名字
 */
@property (nonatomic,copy)NSString * name;

/**
 *  信息
 */
@property (nonatomic,copy)NSString * message;

/**
 *  时间
 */
@property (nonatomic,copy)NSString * time;

@end
