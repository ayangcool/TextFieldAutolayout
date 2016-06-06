//
//  UITableViewLayoutVC.m
//  AutolayoutTextField
//
//  Created by Leo on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "UITableViewLayoutVC.h"
#import "Header.h"
#import "TableViewCell.h"

NSString *const UITableViewLayoutVCIdentifier = @"UITableViewLayoutVCIdentifier";

@interface UITableViewLayoutVC ()<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger cellFrameY;

@end

@implementation UITableViewLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:UITableViewLayoutVCIdentifier];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewLayoutVCIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

- (void)cell:(UITableViewCell *)cell didClickTextField:(UITextField *)textField {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.cellFrameY = (indexPath.row + 1) * 60;
}

- (void)keyboardWillShowNotification:(NSNotification *)notif {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardSize = [value CGRectValue];
    NSLog(@"keyboardSize.origin.y : %f", keyboardSize.origin.y);
    if (self.cellFrameY - self.tableView.contentOffset.y > keyboardSize.origin.y) {
        CGPoint point = self.tableView.contentOffset;
        point.y = point.y + self.cellFrameY - self.tableView.contentOffset.y - keyboardSize.origin.y;
        self.tableView.contentOffset = point;
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notif {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardSize.height : %f", keyboardSize.height);
}

- (void)handleTapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
