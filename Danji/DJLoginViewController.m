//
//  DJLoginViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 6..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJLoginViewController.h"

@implementation DJLoginViewController
{
    __weak IBOutlet UITextField *mUserName;
    __weak IBOutlet UITextField *mPassword;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

@end
