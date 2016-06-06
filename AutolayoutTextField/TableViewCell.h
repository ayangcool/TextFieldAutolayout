//
//  TableViewCell.h
//  AutolayoutTextField
//
//  Created by Leo on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITableViewCell;

@protocol TableViewCellDelegate <NSObject>

- (void)cell:(UITableViewCell *)cell didClickTextField:(UITextField *)textField;

@end

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) id <TableViewCellDelegate>delegate;

@end
