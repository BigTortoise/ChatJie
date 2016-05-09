//
//  RYJSettingViewController.m
//  ChatJie
//
//  Created by 王 on 16/5/6.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJSettingViewController.h"
#import "PreViewController.h"
#import "EMSDK.h"
@interface RYJSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSArray * dataArr;

@end

@implementation RYJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self preData];
}

//准备数据
- (void)preData
{
    
    _dataArr = @[@[@"帐号与安全"],
                 @[@"新消息通知",@"隐私",@"通用"],
                 @[@"帮助与反馈",@"关于微信"],
                 @[@"退出登录"]
                 ];
    
    if(_tableView)
    {
        [_tableView reloadData];
    }
    else
    {
        [self createTableView];
    }
}

//创建tableView
- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        //调整下分隔线位置
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rowArr = _dataArr[section];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataArr.count -1)
    {
        UILabel * backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        backLabel.text = _dataArr[indexPath.section][indexPath.row];
        backLabel.font = [UIFont systemFontOfSize:17];
        backLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:backLabel];
    }
    else
    {
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
        //右侧小箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
}
//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RYJGiveHeight(43);
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return RYJGiveHeight(15);
    }
    return RYJGiveHeight(10);
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return RYJGiveHeight(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            // 退出登录
            EMError *error = [[EMClient sharedClient] logout:YES];
            if (!error) {
                NSLog(@"退出成功");
                
                UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                PreViewController * preVC = [storyBoard instantiateViewControllerWithIdentifier:@"PreViewController"];
                [UIApplication sharedApplication].keyWindow.rootViewController = preVC;
                
                // 设置为非自动登陆
                [[EMClient sharedClient].options setIsAutoLogin:NO];


            } else {
                NSLog(@"退出失败");
            }
            
        }
    }
}



@end


















