//
//  XMGChatCell.m
//  xmg1chat
//
//  Created by xiaomage on 15/9/25.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "XMGChatCell.h"

@implementation XMGChatCell


-(void)setMessages:(EMMessage *)messages{

    _messages = messages;
    
    // 1.获取消息体
    EMMessageBody *msgBody = messages.body;
    
    switch (msgBody.type) {
        case EMMessageBodyTypeText:
        {
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            NSString *txt = textBody.text;
            NSLog(@"收到的文字是 txt -- %@",txt);
            [self.messageBtn setTitle:txt forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }

}


/** 返回cell的高度*/
-(CGFloat)cellHeghit{
    //1.重新布局子控件
    [self layoutIfNeeded];
    
    return 5 + 10 + self.messageBtn.bounds.size.height + 10 + 5;

}


@end
