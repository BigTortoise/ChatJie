//
//  RYJConversationViewController.m
//  ChatJie
//
//  Created by 任 一杰 on 16/5/10.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJConversationViewController.h"
#import "KeyboardView.h"
#import "RYJMessageModel.h"
#import "GroupCell.h"
#import "PrivateCell.h"
#import "WZXTimeStampToTimeTool.h"

@interface RYJConversationViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)KeyboardView * keyView ;


@property(nonatomic,strong)UITableView * tableView ;

@property(nonatomic,strong)NSArray * dataArr ;

@end

@implementation RYJConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self createTableView];
}

- (void)createTableView {
    _tableView = ({
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSceenWidth, kSceenHeight - 64 - 50) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = [UIColor clearColor];
        
        [tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMessageField)]];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (void)hideMessageField
{
    [_keyView.messageField resignFirstResponder];
}

- (void)createUI
{
    _keyView = ({
        
        KeyboardView * keyView = [[KeyboardView alloc]initWithFrame:CGRectMake(0, kSceenHeight - 50, kSceenWidth, 50)];
        
        __weak typeof(KeyboardView) * weakKeyView = keyView;
        
        [keyView setShowBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
            [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
                
                
                CGRect rect = weakKeyView.frame;
                
                rect.origin.y -= kSize.height;
                
                weakKeyView.frame = rect;
                
                CGRect tableRect = _tableView.frame;
                
                tableRect.size.height -= kSize.height;
                
                _tableView.frame = tableRect;
                
                CGFloat contentY = 0;
                
                for (NSDictionary * messageDic in _dataArr)
                {
                    NSArray * modelArr = messageDic[@"messages"];
                    for (int i = 0; i < modelArr.count; i++)
                    {
                        RYJMessageModel * model = modelArr[i];
                        if (i != modelArr.count - 1&& i != modelArr.count - 2)
                        {
                            contentY += model.bubbleSize.height > 40 ? model.bubbleSize.height + 20: 40+20;
                        }
                    }
                }
                
                CGPoint pt = _tableView.contentOffset;
                
                if (contentY > kSize.height)
                {
                    pt.y += kSize.height;
                }
                else
                {
                    pt.y = contentY - 40;
                }
                
                _tableView.contentOffset = pt;
                
            } completion:^(BOOL finished) {
                
            }];
            
        } andHideBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
            [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
                
                CGRect rect = weakKeyView.frame;
                
                rect.origin.y += kSize.height;
                
                weakKeyView.frame = rect;
                
                CGRect tableRect = _tableView.frame;
                
                tableRect.size.height += kSize.height;
                
                _tableView.frame = tableRect;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
        keyView.sentBlock = ^(id response,SentMessageType type)
        {
            if (type == SentMessageTypeText)
            {

            }
            else if(type == SentMessageTypeImg)
            {
                
            }
            else if(type == SentMessageTypeWav)
            {
                
            }
        };
        
        keyView;
    });
    [self.view addSubview:_keyView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary * dic = _dataArr[section];
    NSArray * arr = dic[@"messages"];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    GroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PrivateCell"];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PrivateCell" owner:self options:nil][0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PrivateCell * privateCell = (PrivateCell *)cell;
    
    NSDictionary * dic = _dataArr[indexPath.section];
    NSArray * arr = dic[@"messages"];
    
    RYJMessageModel * model = arr[indexPath.row];
    [privateCell setModel:model];
    
    if (model.isMe == NO)
    {

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = _dataArr[indexPath.section];
    NSArray * arr = dic[@"messages"];
    RYJMessageModel * model = arr[indexPath.row];
    return model.bubbleSize.height > 40 ? model.bubbleSize.height + 20: 40+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 60)/2.0, 10, 60, 20)];
    
    NSDictionary * dic = _dataArr[section];
    
    timeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.clipsToBounds = YES;
    
    double times = [dic[@"timestamp"]doubleValue];
    
    timeLabel.text = [[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:times andScale:3]];
    
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    timeLabel.textColor = [UIColor whiteColor];
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:timeLabel];
    
    return headerView;
}

/** tableview滑到底部 */
- (void)refresh
{
    NSDictionary * dic = _dataArr.lastObject;
    NSArray * arr = dic[@"messages"];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:arr.count - 1 inSection:_dataArr.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

@end
