//
//  QuanModel.h
//  ChatJie
//
//  Created by 王 on 16/5/6.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuanModel : NSObject
/** 发帖人名字 */
@property(nonatomic,copy)NSString * name;

/** 发帖人头像Url */
@property(nonatomic,copy)NSString * avaterUrl;

/** 发帖时间 */
@property(nonatomic,copy)NSString * time;

/** 评论数组 */
@property(nonatomic,copy)NSArray * comments;

/** 图片数组 */
@property(nonatomic,copy)NSArray * imgs;
@end
