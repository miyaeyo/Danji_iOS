//
//  DJParagraphWriteController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJParagraphWriteController.h"


@implementation DJParagraphWriteController
{
    __weak UIViewController<DJParagraphDelegate> *mDelegate;
    __weak IBOutlet UITextView                   *mParagraph;
    __weak IBOutlet UILabel                      *mParagraphPlaceholder;
    CGFloat                                      mRectHeight;
    NSString                                     *mEditingText;
}

@synthesize paragraphDelegate = mDelegate;
@synthesize editingText = mEditingText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [mParagraph setDelegate:self];
    
    if (![mEditingText isEqualToString:@""])
    {
        [mParagraphPlaceholder setText:@""];
        [mParagraph setText:mEditingText];
    }
    
    [self registerForKeyboardNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    [[self view] endEditing:YES];
    [mDelegate paragraphWriteController:self didFinishWriteParagraph:[mParagraph text]];
    [[self navigationController] popToViewController:mDelegate animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [mParagraphPlaceholder setText:@""];
    [self scrollUp];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self scrollUp];
}

- (void)scrollUp
{
    CGFloat contentHeight = [mParagraph contentSize].height;
    
    if (contentHeight >= mRectHeight)
    {
        CGPoint scrollPoint = CGPointMake(0, contentHeight - mRectHeight + 20);
        [mParagraph setContentOffset:scrollPoint animated:YES];
    }
}

#pragma mark - keyboard

- (void)registerForKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets insets =UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    [mParagraph setContentInset:insets];
    [mParagraph setScrollIndicatorInsets:insets];
    
    CGFloat rectHeight = [[self view] frame].size.height - [[[self navigationController] navigationBar] frame].size.height;
    mRectHeight = rectHeight - keyboardSize.height;
    
}

//- (void)keyboardWillHide:(NSNotification *)notification
//{
//    UIEdgeInsets insets = UIEdgeInsetsZero;
//    [mParagraph setContentInset:insets];
//    [mParagraph setScrollIndicatorInsets:insets];
//}


@end
