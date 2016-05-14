//
//  XMGChatingViewController.m
//  07-聊天布局
//
//  Created by xiaomage on 15/6/5.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGChatingViewController.h"
#import "EMSDK.h"
#import "XMGChatCell.h"


@interface XMGChatingViewController () <UITableViewDataSource, UITableViewDelegate,EMClientDelegate,UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *messages;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

/** 计算高度的cell工具对象 */
@property (nonatomic, strong) XMGChatCell *chatCellTool;

@end


@implementation XMGChatingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    // 加载本地数据库聊天记录（MessageV1）
    [self loadLocalChatRecords];
    
    // 设置文本框左边的内容
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 10, 0);
//    self.messageField.leftView = leftView;
//    self.messageField.leftViewMode = UITextFieldViewModeAlways;
    
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)loadLocalChatRecords {
    // 获取会话列表
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"22222222222" type:EMConversationTypeChat createIfNotExist:YES];
    // 获取会话中的全部聊天记录
//    EMMessage *msg = [conversation loadMessageWithId:@"22222222222"];
    long longFrom = 0;
    long longTo = 10;
    // 加载与当前聊天用户所有聊天记录
    NSArray *messages = [conversation loadMoreMessagesFrom:longFrom to:longTo maxCount:10];

    
    // 添加到数据源
    [self.messages addObjectsFromArray:messages];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘处理
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        self.view.transform = CGAffineTransformMakeTranslation(0, - ty);
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.messages.count;
//    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 设置label的数据
    // 1.获取消息模型
    EMMessage *msg = self.messages[indexPath.row];
    
    self.chatCellTool.messages = msg;
    
    return [self.chatCellTool cellHeghit];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.先获取消息模型
    EMMessage *message = self.messages[indexPath.row];
    //    EMMessage
    /* from:xmgtest1 to:xmgtest7 发送方（自己）
     * from:xmgtest7 to:xmgtest1 接收方 （好友）
     */
    
    XMGChatCell *cell = nil;
    if ([message.from isEqualToString:@"22222222222"]) {//接收方
        cell = [tableView dequeueReusableCellWithIdentifier:ReceiverCell];
    }else{//发送方
        cell = [tableView dequeueReusableCellWithIdentifier:SenderCell];
    }
    //显示内容
    cell.messages = message;
    NSLog(@"%@",message);
    
    return cell;

}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
//    [self.messageField resignFirstResponder];
//    [self.messageField endEditing:YES];
    [self.view endEditing:YES];
}


#pragma mark - UITextView代理
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    
    // 监听Send事件--判断最后的一个字符是不是换行字符
    if ([textView.text hasSuffix:@"\n"]) {
        NSLog(@"发送操作");
        [self sendMessage:textView.text];
        
        // 清空textView的文字
        textView.text = nil;
    }
   
}
#pragma mark - 发送消息
- (void)sendMessage:(NSString *)text {
    // 把最后一个换行字符去除
#warning 换行字符 只占用一个长度
    text = [text substringToIndex:text.length - 1];
    
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    EMMessage *message = [[EMMessage alloc]initWithConversationID:@"22222222222" from:from to:@"22222222222" body:body ext:nil];
    
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        NSLog(@"%i",progress);
    } completion:^(EMMessage *message, EMError *error) {
        NSLog(@"%@ - %@",message,error);
    }];
    
    // 3.把消息添加到数据源，然后再刷新表格
    [self.messages addObject:message];
    [self.tableView reloadData];
    // 4.把消息显示在顶部
    [self scrollToBottom];
}
//把消息显示在顶部的方法
- (void)scrollToBottom{
    //获取最后一行
    if (self.messages.count == 0) {
        return;
    }
    
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}

- (void)didReceiveMessages:(NSArray *)aMessages
{
    //1.把接收的消息添加到数据源
    [self.messages addObject:aMessages];
    
    //2.刷新表格
    [self.tableView reloadData];
    
    //3.显示数据到底部
    [self scrollToBottom];

}

@end











