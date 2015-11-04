//
//  DJDialogInputCell.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJDialogInputCell;

@protocol DJDialogInputCellDelegate <NSObject>

@required
- (void)dialogInputCellDidDeleted:(DJDialogInputCell *)cell;
- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingCharacter:(NSString *)character;
- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingDialog:(NSString *)dialog;

@end


@interface DJDialogInputCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic) NSInteger number;
@property (weak, nonatomic) IBOutlet UITextField *character;
@property (weak, nonatomic) IBOutlet UITextView *dialog;
@property (weak, nonatomic) IBOutlet UILabel *dialogPlaceholder;
@property (nonatomic, weak) id<DJDialogInputCellDelegate> delegate;


@end
