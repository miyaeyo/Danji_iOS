//
//  DJSignupViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSignupViewController.h"


@implementation DJSignupViewController
{
    __weak IBOutlet UITextField *mUserName;
    __weak IBOutlet UITextField *mPassword;
    __weak IBOutlet UITextField *mConfirmPassword;
    IBOutlet UIScrollView       *mScrollView;
    __weak UITextField          *mActiveField;
    
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mUserName setDelegate:self];
    [mPassword setDelegate:self];
    [mConfirmPassword setDelegate:self];
    
    //keyboard control
    [self registerForKeyboardNotification];
    UITapGestureRecognizer *backgroundTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [mScrollView addGestureRecognizer:backgroundTapGesture];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        mUserName = nil;
        mPassword = nil;
        mConfirmPassword = nil;
        mScrollView = nil;
        mActiveField = nil;
    }
}


#pragma mark - action

- (IBAction)registerButtonTapped:(id)sender
{
    if ([[mUserName text] length] != 0 && [[mUserName text] length] <= 10
        && [[mPassword text] length] != 0 && [[mPassword text] length] >= 8
        && [[mPassword text] isEqualToString:[mConfirmPassword text]])
    {
        [self signUp];
    }
    else if ([[mUserName text] length] == 0 || [[mPassword text] length] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing information"
                                    message:@"Make sure you fill all of the information"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Not match password"
                                    message:@"Check your password"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (IBAction)backgroundTapped:(id)sender
{
    //keyboard hide
    [[self view] endEditing:YES];
}


#pragma mark - text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    mActiveField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    mActiveField = nil;
    
    //password length check
    if ([textField tag] == 1 && [[textField text] length] < 8)
    {
        [[[UIAlertView alloc] initWithTitle:@"Check password length"
                                    message:@"Password must be 8 or more characters"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    //contirm password check
    else if([textField tag] == 2)
    {
        if (![[textField text] isEqualToString:[mPassword text]])
        {
            [[[UIAlertView alloc] initWithTitle:@"Not match password"
                                        message:@"Check your password"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil] show];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //user name length check
    if([textField tag] == 0 && [[[textField text] stringByAppendingString:string] length] > 10)
    {
        [[[UIAlertView alloc] initWithTitle:@"Check user name length"
                                    message:@"User name must be 10 characters or less"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        return NO;
    }
    //when password is too long
    else if([textField tag] == 1 && [[[textField text] stringByAppendingString:string] length] > 40)
    {
        [[[UIAlertView alloc] initWithTitle:@"Password is too long"
                                    message:@"You can determine other password which is easy to remember"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
        return NO;
    }

    return YES;
}


#pragma mark - keyboard

- (void)registerForKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    [mScrollView setContentInset:insets];
    [mScrollView setScrollIndicatorInsets:insets];
    
    CGRect rect = [self view].frame;
    rect.size.height -= keyboardSize.height;
    
    CGPoint activeFieldEndPoint = CGPointMake([mActiveField frame].origin.x, [mActiveField frame].origin.y + [mActiveField frame].size.height);
    
    if (!CGRectContainsPoint(rect, activeFieldEndPoint))
    {
        CGPoint scrollPoint = CGPointMake(0, rect.size.height - [mActiveField frame].origin.y + 10);
        [mScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    [mScrollView setContentInset:insets];
    [mScrollView setScrollIndicatorInsets:insets];
}


#pragma mark - private

- (void)signUp
{
    PFUser *user = [PFUser user];
    [user setUsername:[mUserName text]];
    [user setPassword:[mPassword text]];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             [self performSegueWithIdentifier:@"signupCompleted" sender:self];
         }
         else if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Fail to signup"
                                         message:@"Username already taken"
                                        delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil, nil] show];
             
             return;

         }
                  
     }];
}


@end
