//
//  DJDialogInputCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJDialogInputCell.h"

@implementation DJDialogInputCell
{
    __weak id<DJDialogInputCellDelegate> mDelegate;
    __weak IBOutlet UITextField         *mCharacter;
    __weak IBOutlet UITextView          *mDialog;
    __weak IBOutlet UILabel             *mDialogPlaceholder;
    
    NSInteger                           mNumber;
    
}

@synthesize number = mNumber;
@synthesize delegate = mDelegate;
@synthesize dialog = mDialog;
@synthesize character = mCharacter;


#pragma mark - action

- (IBAction)minusButtonTapped:(id)sender
{
    [mDelegate dialogInputCellDidDeleted:self];
}

- (IBAction)characterDidChange:(id)sender
{
    [mDelegate dialogInputCell:self didEndEditingCharacter:[mCharacter text]];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [mDialogPlaceholder setText:@""];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [mDelegate dialogInputCell:self didEndEditingDialog:[mDialog text]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

@end
