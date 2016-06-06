//
//  RootViewController.m
//  AutolayoutTextField
//
//  Created by Leo on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "RootViewController.h"

#define kTextFieldHeight 40
#define kTextFieldSpace 10

@interface RootViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) NSInteger textFieldFrameY;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.backView];
    for (int i = 0; i < 10; i++) {
        /// textField 间隔10 宽40
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 +  10 + (kTextFieldHeight + kTextFieldSpace) * i, self.view.bounds.size.width - 20, kTextFieldHeight)];
        textField.backgroundColor = [UIColor purpleColor];
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyNext;
        [self.backView addSubview:textField];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardWillShowNotification:(NSNotification *)notif {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardSize = [value CGRectValue];
    NSLog(@"keyboardSize.origin.y : %f", keyboardSize.origin.y);
    if (self.textFieldFrameY + (kTextFieldHeight + kTextFieldSpace / 2.0) > keyboardSize.origin.y) {
        CGRect frame = self.backView.frame;
        frame.origin.y = keyboardSize.origin.y - self.textFieldFrameY - self.backView.frame.origin.y - (kTextFieldHeight + kTextFieldSpace / 2.0);
        if (frame.origin.y < 0) {
            self.backView.frame = frame;
        }
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notif {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardSize.height : %f", keyboardSize.height);
    if (self.backView.frame.origin.y != 0) {
        CGRect frame = self.backView.frame;
        frame.origin.y = 0;
        self.backView.frame = frame;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldFrameY = textField.frame.origin.y;
}

- (void)handleTapAction:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
