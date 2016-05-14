//
//  XMGChatCell.h
//  xmg1chat
//
//  Created by xiaomage on 15/9/25.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "EMMessageBody.h"
static NSString *ReceiverCell = @"me";
static NSString *SenderCell = @"other";
@interface XMGChatCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *messageBtn;

/** 消息模型，内部set方法 显示文字 */
@property (nonatomic, strong) EMMessage *messages;

-(CGFloat)cellHeghit;

@end
