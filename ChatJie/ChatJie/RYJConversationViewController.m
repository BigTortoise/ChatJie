//
//  RYJConversationViewController.m
//  ChatJie
//
//  Created by 任 一杰 on 16/5/10.
//  Copyright © 2016年 renyijie. All rights reserved.
//

#import "RYJConversationViewController.h"

@interface RYJConversationViewController () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation RYJConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}
@end
