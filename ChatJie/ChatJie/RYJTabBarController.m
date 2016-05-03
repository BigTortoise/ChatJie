//
//  RYJTabBarController.m
//  ChatMe
//
//  Created by 王 on 16/4/27.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJTabBarController.h"

#import "RYJAddressBookViewController.h"
#import "RYJCahtViewController.h"
#import "RYJFoundViewController.h"
#import "RYJMeViewController.h"

@interface RYJTabBarController ()

@end

@implementation RYJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RYJCahtViewController *chatVC = [[RYJCahtViewController alloc]init];
    chatVC.title = @"微信";


    RYJAddressBookViewController *addressVC = [[RYJAddressBookViewController alloc]init];
    addressVC.title = @"通讯录";
    
    
    RYJFoundViewController *foundVC = [[RYJFoundViewController alloc]init];
    foundVC.title = @"发现";
    
    RYJMeViewController *meVC = [[RYJMeViewController alloc]init];
    meVC.title = @"我";
    
    self.viewControllers = @[
                              [self giveMeNavWithVC:chatVC andImgName:@"tabbar_chat_no" andSelectImgName:@"tabbar_chat_yes"],
                              
                             [self giveMeNavWithVC:addressVC andImgName:@"tabbar_book_no" andSelectImgName:@"tabbar_book_yes"],
                             
                             [self giveMeNavWithVC:foundVC andImgName:@"tabbar_found_no"andSelectImgName:@"tabbar_found_yes"],
                             
                             [self giveMeNavWithVC:meVC andImgName:@"tabbar_me_no"andSelectImgName:@"tabbar_me_yes"]
                             ];
    
    self.tabBar.tintColor = [UIColor colorWithRed:9/255.0 green:187/255.0 blue:7/255.0 alpha:1];

}

/**
 *  返回取消渲染的image
 */
- (UIImage *)removeRendering:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  快速创建Nav
 */
- (UINavigationController *)giveMeNavWithVC:(UIViewController *)VC andImgName:(NSString *)imgName andSelectImgName:(NSString *)selectImgName
{
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:VC.tabBarItem.title image:[self removeRendering:imgName] selectedImage:[self removeRendering:selectImgName]];
    
    return nav;
}



@end
