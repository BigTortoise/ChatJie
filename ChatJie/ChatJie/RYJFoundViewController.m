//
//  RYJFoundViewController.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJFoundViewController.h"

@interface RYJFoundViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
//名字数组
@property(nonatomic,copy)NSArray *dataArray;
// 图片数组
@property(nonatomic,copy)NSArray *imageArray;

@end

@implementation RYJFoundViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 准备数据
    [self preData];
    
    // 创建tabelview
    [self createTableView];
    
}

- (void)preData {
    _dataArray = @[@[@"朋友圈"],
                   @[@"扫一扫",@"摇一摇"],
                   @[@"附近的人"],
                   @[@"购物",@"游戏"]
                   ];
    
    _imageArray = @[@[@"found_quan"],
                @[@"found_saoyisao",@"found_yao"],
                @[@"found_nearby"],
                @[@"found_shop",@"found_game"]];

}

- (void)createTableView{
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

#pragma mark - UITableViewDataSource
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
// 每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArray = self.dataArray[section];
    return rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"foundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

// 养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
}

// 设置row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RYJGiveHeight(43);
}

//设置头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return RYJGiveHeight(15);
    }
    return RYJGiveHeight(10);
}

// 设置脚视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  RYJGiveHeight(10);
}
@end
















