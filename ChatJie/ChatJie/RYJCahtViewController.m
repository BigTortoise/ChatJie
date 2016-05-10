//
//  RYJCahtViewController.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJCahtViewController.h"
#import "ChatCell.h"
#import "EMSDK.h"
#import "RYJConversationViewController.h"

@interface RYJCahtViewController () <UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,EMClientDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISearchController * searchController;

@end

@implementation RYJCahtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加回调监听代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self createTableView];
}
// 监听网络状况
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState {
    if (aConnectionState == 0) {
        NSLog(@"连接正常");
        self.title = @"微信";
    } else if (aConnectionState == 1) {
        NSLog(@"连接断开");
        self.title = @"连接断开";
    }
}
- (void)createTableView
{
    _tableView = ({
        
        UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStyleGrouped];
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableview;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ChatCell" owner:self options:nil][0];
    }
    cell.avaterImgView.image = [UIImage imageNamed:@"me"];
    cell.nameLabel.text = @"乔布斯";
    cell.messageLabel.text = @"Stay hungry Stay foolish!";
    cell.timeLabel.text = @"11:11";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RYJGiveHeight(65);
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RYJGiveHeight(43);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
//    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    
    self.searchController.searchBar.backgroundImage = [[UIImage alloc]init];
    
    self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    
    self.searchController.searchBar.tintColor = [UIColor blueColor];
    
    self.searchController.searchBar.placeholder = @"搜索";
    
    
    
    return self.searchController.searchBar;
}
- (void)willPresentSearchController:(UISearchController *)searchController
{
    [self.glassView showToView:self.view];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    [self.glassView hide];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RYJConversationViewController *ConversationVC = [[RYJConversationViewController alloc]init];
    ConversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ConversationVC animated:YES];
}

@end
