//
//  RYJAddressBookViewController.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJAddressBookViewController.h"
#import "NSString+PinYin.h"
#import "RYJPersonModel.h"

@interface RYJAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataArr;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UISearchController * searchController;

@property(nonatomic,copy)NSArray * sectionArr;

@property(nonatomic,strong)NSMutableArray * searchArr;
@end

@implementation RYJAddressBookViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //准备数据
    [self preData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自动调整scrollview的 inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];
}
- (void)preData {
    _dataArr = @[
                 @{
                     @"name":@"马化腾",
                     @"imgName":@"me"
                     },
                 @{
                     @"name":@"马云",
                     @"imgName":@"me"
                     },
                 @{
                     @"name":@"乔布斯",
                     @"imgName":@"me"
                     },
                 @{
                     @"name":@"库里",
                     @"imgName":@"me"
                     }
                 ];
    
    _sectionArr = @[
                    @{
                        @"name":@"新的朋友",
                        @"imgName":@"book_newfriend"
                        },
                    @{
                        @"name":@"群聊",
                        @"imgName":@"book_group"
                        },
                    @{
                        @"name":@"标签",
                        @"imgName":@"book_tag"
                        },
                    @{
                        @"name":@"公众号",
                        @"imgName":@"book_gong"
                        }
                    ];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return self.dataArr.count + 1;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return _sectionArr.count;
    }
    else
    {
        /*
         NSDictionary * dic = _dataArr[section];
         NSArray * arr = dic[@"nameArr"];
         return arr.count;
         */
        return _dataArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"bookCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}


//在willDisplayCell处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSDictionary *dic = self.sectionArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dic[@"imgName"]];
        cell.textLabel.text = dic[@"name"];
    } else {
        NSDictionary *dic = self.dataArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dic[@"imgName"]];
        cell.textLabel.text = dic[@"name"];
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RYJGiveHeight(55);
}



//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return RYJGiveHeight(43);
    }
    return RYJGiveHeight(20);
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return RYJGiveHeight(0.01);
}
@end












