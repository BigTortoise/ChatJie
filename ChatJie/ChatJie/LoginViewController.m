//
//  LoginViewController.m
//  ChatJie
//
//  Created by 王 on 16/5/7.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "LoginViewController.h"
#import "RYJTabBarController.h"
#import "EMSDK.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumbertext;
@property (weak, nonatomic) IBOutlet UITextField *passWordtext;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听填入手机号码
    [self.phoneNumbertext addTarget:self action:@selector(textChang) forControlEvents:UIControlEventEditingChanged];
    [self.passWordtext addTarget:self action:@selector(textChang) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // 进入界面启动键盘
    [self.phoneNumbertext becomeFirstResponder];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // 退出界面关闭键盘
    [self.phoneNumbertext resignFirstResponder];
    [self.passWordtext resignFirstResponder];


}
- (void)textChang {
    if (self.phoneNumbertext.text.length == 11 ) {
        // 当输入的电话号码为11位时退出键盘
        [self.phoneNumbertext resignFirstResponder];
        
        if (self.passWordtext.text.length > 0) {
            
            self.loginBtn.enabled = YES;

        }
    }
}
- (IBAction)dismissBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 登陆
- (IBAction)loginBtnClick:(id)sender {
    
    

    
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.phoneNumbertext.text password:self.passWordtext.text];
    if (!error) {
        NSLog(@"登陆成功");
        
        [self presentViewController:[[RYJTabBarController alloc]init] animated:YES completion:^{
            
        }];
        
        
    } else {
        NSLog(@"登陆失败");
        
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
