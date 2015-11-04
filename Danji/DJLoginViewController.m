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
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        mUserName = nil;
        mPassword = nil;
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


#pragma mark - action

- (IBAction)loginButtonTapped:(id)sender
{
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
    [[self view] endEditing:YES];
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
