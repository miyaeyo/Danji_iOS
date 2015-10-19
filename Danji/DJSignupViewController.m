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
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mUserName = nil;
    mPassword = nil;
    mConfirmPassword = nil;
}


#pragma mark - action

- (IBAction)registerButtonTapped:(id)sender
{
    if ([[mUserName text] length] != 0 && [[mPassword text] length] != 0 && [[mPassword text] isEqualToString:[mConfirmPassword text]])
    {
        //to do: id length, password length check
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


#pragma mark - private

- (void)signUp
{
    PFUser *user = [PFUser user];
    [user setUsername:[mUserName text]];
    [user setPassword:[mPassword text]];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"fail to signup"
                                         message:@"Username already taken"
                                        delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil, nil] show];
             
             return;

         }
         
         
        [[[UIAlertView alloc] initWithTitle:@"success to signup"
                                    message:@"welcome Danji, login and enjoy Danji"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
             
         [PFUser logOut];
         [self performSegueWithIdentifier:@"signupCompleted" sender:self];
         
     }];
    
}


@end
