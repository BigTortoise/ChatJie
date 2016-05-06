//
//  RYJMeViewController.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJMeViewController.h"
#import "RYJPersonModel.h"
#import "RYJPersonCell.h"
#import "RYJPersonViewController.h"
#import "RYJChangDataViewController.h"
#import "RYJSettingViewController.h"

@interface RYJMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray * dataArr;

@property(nonatomic,copy)NSArray * imgArr;

@property(nonatomic,strong)RYJPersonModel * model;

@end

@implementation RYJMeViewController
- (void)viewWillAppear:(BOOL)animated {
    [self preData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];
}
//准备数据
- (void)preData
{
    
    _dataArr = @[@[@""],
                 @[@"相册",@"收藏",@"钱包"],
                 @[@"表情"],
                 @[@"设置"]
                 ];
    
    _imgArr = @[@[@""],
                @[@"me_photo",@"me_collect",@"me_money"],
                @[@"me_smail"],
                @[@"me_setting"]
                ];
    
    _model = [[RYJPersonModel alloc]init];
    _model.avater = @"me";
    _model.nickName = @"Jie_iOS";
    _model.weID = @"JJ_REN";
    
    if(_tableView)
    {
        [_tableView reloadData];
    }
}
//创建tableView
- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        //调整下分隔线位置
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    [self.view addSubview:_tableView];
}


//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

//每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArray = self.dataArr[section];
    return rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RYJPersonCell *cell = [[RYJPersonCell alloc]init];

        return cell;
    } else {
        static NSString *ID = @"meCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RYJPersonCell *personCell = (RYJPersonCell *)cell;
        [personCell setModel:_model];
    } else {
        cell.imageView.image = [UIImage imageNamed:_imgArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return RYJGiveHeight(87);
    }
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
    if (indexPath.section == 0) {
        // 我
        if (indexPath.row == 0) {
            RYJPersonViewController *personVC = [[RYJPersonViewController alloc]init];
            personVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personVC animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        // 相册
        if (indexPath.row == 0) {
            
        }
        // 收藏
        else if (indexPath.row == 1) {
            
        }
        // 钱包
        else if (indexPath.row == 2) {
            
        }
    }
    else if (indexPath.section == 2) {
        // 表情
        if (indexPath.row == 0) {
            
        }
    }
    else if (indexPath.section == 3) {
        // 设置
        if (indexPath.row == 0) {
            RYJSettingViewController *settingVC = [[RYJSettingViewController alloc]init];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }
}
@end





















