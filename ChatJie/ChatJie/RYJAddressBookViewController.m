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
@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UISearchController * searchController;

@property(nonatomic,copy)NSArray * sectionArr;

@property(nonatomic,strong)NSMutableArray * searchArr;
@end

@implementation RYJAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self addRightBtnWithImgName:@"book_addfriend" andSelector:@selector(rightBtnClick:)];
    //准备数据
    [self preData];
}

- (void)preData
{
    _dataArr = [[NSMutableArray alloc]init];
    
    _searchArr = [[NSMutableArray alloc]init];
    
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
    
    NSArray * nameArr = @[
                          @{
                              @"name":@"马云",
                              @"imgName":@"me"
                              },
                          @{
                              @"name":@"任一杰",
                              @"imgName":@"me"
                              },
                          @{
                              @"name":@"库里",
                              @"imgName":@"me"
                              },
                          @{
                              @"name":@"乔布斯",
                              @"imgName":@"me"
                              }
                          ];
    
    for(char i = 'A';i <= 'Z';i++)
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        for (int j = 0; j < nameArr.count; j++)
        {
            NSDictionary * nameDic = nameArr[j];
            NSString * name = nameDic[@"name"];
            NSString * imgName = nameDic[@"imgName"];
            NSString * sectionName = [NSString stringWithFormat:@"%c",i];
            
            //属于这个组的nameArr
            NSMutableArray * currNameArr = [[NSMutableArray alloc]init];
            if ([[name getFirstLetter] isEqualToString:sectionName])
            {
                NSDictionary * currDic = @{
                                           @"name":name,
                                           @"imgName":imgName
                                           };
                
                [currNameArr addObject:currDic];
            }
            
            if (currNameArr.count > 0)
            {
                [dic setObject:currNameArr forKey:@"nameArr"];
                [dic setObject:sectionName forKey:@"sectionName"];
                [_dataArr addObject:dic];
            }
        }
        
    }
    NSLog(@"%@",_dataArr);
    
    [self createTableView];
}

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

- (void)rightBtnClick:(UIButton *)sender
{
    NSLog(@"点击了");
}

#pragma mark --tableView--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _sectionArr.count;
    }
    else
    {
        NSDictionary * dic = _dataArr[section - 1];
        NSArray * arr = dic[@"nameArr"];
        return arr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"bookCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSDictionary * dic = _sectionArr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:dic[@"imgName"]];
        
        cell.textLabel.text = dic[@"name"];
    }
    else
    {
        
        NSDictionary * dic = _dataArr[indexPath.section - 1];
        
        NSArray * arr = dic[@"nameArr"];
        
        //当前cell的信息
        NSDictionary * rowDic = arr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:rowDic[@"imgName"]];
        
        cell.textLabel.text = rowDic[@"name"];
        
        UIImage *icon = [UIImage imageNamed:rowDic[@"imgName"]];
        
        //修改icon尺寸
        CGSize itemSize = CGSizeMake(RYJGiveWidth(36), RYJGiveWidth(36));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
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

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, RYJGiveWidth(30), RYJGiveHeight(20))];
        
        NSDictionary * dic = _dataArr[section - 1];
        
        label.text = [NSString stringWithFormat:@"   %@",dic[@"sectionName"]];
        
        label.textAlignment = NSTextAlignmentLeft;
        
        label.font = [UIFont systemFontOfSize:10];
        
        label.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:146/255.0 alpha:1];
        
        return label;
    }
    //搜索框
    else
    {
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        //self.searchController.searchResultsUpdater = self;
        
        self.searchController.dimsBackgroundDuringPresentation = YES;
        
        [self.searchController.searchBar sizeToFit];
        
        //self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        self.searchController.searchBar.backgroundImage = [[UIImage alloc]init];
        
        self.searchController.searchBar.placeholder = @"搜索";
        
        return self.searchController.searchBar;
    }
    return nil;
}

//加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    //索引背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    //索引颜色
    tableView.sectionIndexColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    //加放大镜
    [arr addObject:UITableViewIndexSearch];
    
    for (NSDictionary * dic in _dataArr)
    {
        [arr addObject:dic[@"sectionName"]];
    }
    return arr;
}

#pragma mark --选中Cell的方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - searchController delegate

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end












