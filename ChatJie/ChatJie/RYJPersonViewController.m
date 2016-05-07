//
//  RYJPersonViewController.m
//  ChatJie
//
//  Created by 王 on 16/5/6.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJPersonViewController.h"
#import "RYJChangDataViewController.h"

@interface RYJPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * titleArr;

@property(nonatomic,copy)NSArray * valueArr;
@end

@implementation RYJPersonViewController
{
    UIImage * _avaterImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self preData];
}

- (void)preData
{
    _titleArr = @[
                  @[
                      @"头像",
                      @"名字",
                      @"微信号",
                      @"我的二维码",
                      @"我的地址"
                      ]
                  ,
                  @[
                      @"性别",
                      @"地区",
                      @"个性签名"
                      ]
                  
                  ];
    
    _valueArr = @[
                  @[
                      @"me_wm",
                      @"任一杰",
                      @"Jie_iOS",
                      @"me_wm",
                      @""
                      ]
                  ,
                  @[
                      @"男",
                      @"浙江 杭州",
                      @"Keep Coding "
                      ]
                  
                  ];
    
    if (_tableView)
    {
        [_tableView reloadData];
    }
    else
    {
        [self createTableView];
    }
}
- (void)createTableView {
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);;
        
        tableView;
    });
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = _titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"person";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

// 习惯在willDisplayCell给cell赋值
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(RYJGiveWidth(220), (cell.frame.size.height - RYJGiveHeight(64))/2.0, RYJGiveHeight(64), RYJGiveHeight(64))];
        
        imageView.image = [UIImage imageNamed:@"me"];
        
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 0 && indexPath.row == 3)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(RYJGiveWidth(270), (cell.frame.size.height - RYJGiveHeight(18))/2.0, RYJGiveHeight(18), RYJGiveHeight(18))];
        
        imageView.image = [UIImage imageNamed:@"me_wm"];
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        UILabel * signLabel = [[UILabel alloc]initWithFrame:CGRectMake(RYJGiveWidth(148), 0, RYJGiveWidth(145), cell.frame.size.height)];
        signLabel.text = @"HHH";
        signLabel.textAlignment = NSTextAlignmentRight;
        signLabel.textColor = [UIColor grayColor];
        signLabel.numberOfLines = 0;
        [cell.contentView addSubview:signLabel];
    }
    else
    {
        NSLog(@"font%@  color%@",cell.textLabel.font,cell.textLabel.textColor);
        cell.detailTextLabel.text = _valueArr[indexPath.section][indexPath.row];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return RYJGiveHeight(80);
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
       return RYJGiveHeight(44);
    }
    else
    {
        return RYJGiveHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return RYJGiveHeight(15);
    }
    else
    {
        return RYJGiveHeight(20);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //修改头像
        if (indexPath.row == 0)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
           
            [self.navigationController pushViewController:changeDataVC animated:YES];
        }
        //修改用户名
        else if(indexPath.row == 1)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
            
            [self.navigationController pushViewController:changeDataVC animated:YES];

        }
        //微信号（不能修改）
        else if(indexPath.row == 2)
        {
            
        }
        //二维码
        else if(indexPath.row == 3)
        {
            
        }
        //地址
        else if(indexPath.row == 4)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
            
            [self.navigationController pushViewController:changeDataVC animated:YES];

        }
    }
    else
    {
        //性别
        if (indexPath.row == 0)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
            
            [self.navigationController pushViewController:changeDataVC animated:YES];

        }
        //地区
        else if(indexPath.row == 1)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
            
            [self.navigationController pushViewController:changeDataVC animated:YES];

        }
        //个性签名
        else if(indexPath.row == 2)
        {
            RYJChangDataViewController * changeDataVC = [[RYJChangDataViewController alloc]init];
            
            [self.navigationController pushViewController:changeDataVC animated:YES];

        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
