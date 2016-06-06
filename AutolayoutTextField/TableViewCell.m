//
//  TableViewCell.m
//  AutolayoutTextField
//
//  Created by Leo on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "TableViewCell.h"
#import "Header.h"

@interface TableViewCell ()<UITextFieldDelegate>

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

- (void)initCell {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 20, kTextFieldHeight)];
    textField.backgroundColor = [UIColor purpleColor];
    textField.delegate = self;
    [self.contentView addSubview:textField];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didClickTextField:)]) {
        [self.delegate cell:self didClickTextField:textField];
    }
}

@end
