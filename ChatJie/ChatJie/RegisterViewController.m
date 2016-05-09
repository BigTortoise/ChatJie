//
//  RegisterViewController.m
//  ChatJie
//
//  Created by 王 on 16/5/7.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "EMSDK.h"
#import "RYJTabBarController.h"
#import "MBProgressHUD+XMG.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneNumber becomeFirstResponder];
    
    //监听填入手机号码
    [_phoneNumber addTarget:self action:@selector(textChang) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.phoneNumber resignFirstResponder];
}
- (void)textChang {
    // 当填入手机号长度 = 11位才可以注册
    if( self.phoneNumber.text.length == 11 ){
        
        [self.phoneNumber resignFirstResponder];
        
        self.registerBtn.enabled = YES;
    }
}
// 取消按钮
- (IBAction)dismissBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 注册
- (IBAction)registerBtn:(id)sender {
    
    // 提示用户，正在登录ing...
    [MBProgressHUD showMessage:@"正在注册ing..."];
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.phoneNumber.text password:@"111"];
    if (error == nil) {
        NSLog(@"注册成功");
        
        [MBProgressHUD hideHUD];
        
        [self presentViewController:[[RYJTabBarController alloc]init] animated:YES completion:^{
            
        }];

    } else {
        NSLog(@"注册失败");
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"注册失败"];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
