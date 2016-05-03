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

- (void)viewWillAppear:(BOOL)animated {
    
    //准备数据
    [self preData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}
- (void)preData {
    NSArray * nameArr = @[
                          @{
                              @"name":@"马化腾",
                              @"imgName":@"avater.jpg"
                              },
                          @{
                              @"name":@"张小龙",
                              @"imgName":@"avater.jpg"
                              },
                          @{
                              @"name":@"乔帮主",
                              @"imgName":@"avater.jpg"
                              },
                          @{
                              @"name":@"库里",
                              @"imgName":@"avater.jpg"
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
    return self.dataArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        NSDictionary * dic = _dataArr[indexPath.section - 1];
        
        NSArray * arr = dic[@"nameArr"];
        
        //当前cell的信息
        RYJPersonModel * model = arr[indexPath.row];
        
        
        cell.textLabel.text = model.nickName;
        
        UIImage *icon = cell.imageView.image;
        
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
@end













