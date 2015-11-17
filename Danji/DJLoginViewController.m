//
//  DJLoginViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 6..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJLoginViewController.h"
#import "DJContentsManager.h"


@implementation DJLoginViewController
{
    __weak IBOutlet UITextField *mUserName;
    __weak IBOutlet UITextField *mPassword;
    IBOutlet UIScrollView       *mScrollView;
    __weak          UITextField *mActiveField;
    
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mUserName setDelegate:self];
    [mPassword setDelegate:self];
    
    //keyboard control
    [self registerForKeyboardNotifications];
    UITapGestureRecognizer *backgroundTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [mScrollView addGestureRecognizer:backgroundTapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        mUserName = nil;
        mPassword = nil;
        mScrollView = nil;
        mActiveField = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"startDanji" sender:self];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - action

- (IBAction)loginButtonTapped:(id)sender
{
    //keyboard hide
    [[self view] endEditing:YES];
    
    if ([[mUserName text] length] == 0 || [[mPassword text] length] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing information"
                                    message:@"Make sure you fill all of the information"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
        return;
    }
    
    [self login];
}

- (IBAction)backgroundTapped:(id)sender
{
    //keyboard hide
    [[self view] endEditing:YES];
}


#pragma mark - keyboard

- (void)registerForKeyboardNotifications
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
    UIEdgeInsets insets =UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    [mScrollView setContentInset:insets];
    [mScrollView setScrollIndicatorInsets:insets];
    
    CGRect rect = [self view].frame;
    rect.size.height -= (keyboardSize.height + 10);
    
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


#pragma mark - text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    mActiveField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    mActiveField = nil;
}


#pragma mark - private

- (void)login
{
    [PFUser logInWithUsernameInBackground:[mUserName text]
                                 password:[mPassword text]
                                    block:^(PFUser *user, NSError *error)
     {
         if (user)
         {
             [self performSegueWithIdentifier:@"startDanji" sender:self];
             
             return;
         }
         
         [[[UIAlertView alloc] initWithTitle:@"fail to login"
                                     message:@"Check your input or signup"
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil, nil] show];
         
     }];

}


@end
