//
//  RootViewController.m
//  AutolayoutTextField
//
//  Created by Leo on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewLayoutVC.h"
#import "UITableViewLayoutVC.h"

@interface RootViewController ()<UITextFieldDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(0, 0, 300, 40);
    viewButton.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
    [viewButton setTitle:@"UIView输入框自适应键盘" forState:UIControlStateNormal];
    viewButton.backgroundColor = [UIColor redColor];
    [viewButton addTarget:self action:@selector(handleViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewButton];
    UIButton *tableViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tableViewButton.frame = CGRectMake(0, 0, 300, 40);
    tableViewButton.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
    [tableViewButton setTitle:@"UITableView输入框自适应键盘" forState:UIControlStateNormal];
    [tableViewButton addTarget:self action:@selector(handleTableViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    tableViewButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tableViewButton];
}

- (void)handleViewButtonAction:(UIButton *)sender {
    [self.navigationController pushViewController:[UIViewLayoutVC new] animated:YES];
}

- (void)handleTableViewButtonAction:(UIButton *)sender {
    [self.navigationController pushViewController:[UITableViewLayoutVC new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
