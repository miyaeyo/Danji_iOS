//
//  DJHomeViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJHomeViewController.h"


@implementation DJHomeViewController


#pragma mark - view


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self tabBarController] tabBar] setTintColor:[UIColor whiteColor]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action


- (IBAction)logoutButtonTapped:(id)sender
{
    //logout
}


@end


//- (void)setupNavigationBar
//{
//    UINavigationBar *navBar = [[self navigationController] navigationBar];
//    UIView *titleView = [[UIView alloc] initWithFrame:[navBar bounds]];
//
//    UIImageView *appIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danji.png"]];
//    [appIcon setFrame:CGRectMake(0, 0, [appIcon bounds].size.width, [navBar bounds].size.height)];
//
//    UILabel *title = [[UILabel alloc] initWithFrame:[navBar bounds]];
//    [title setTextAlignment:NSTextAlignmentCenter];
//    [title setTextColor:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]];
//    [title setFont:[UIFont boldSystemFontOfSize:20.0]];
//    [title setText:@"DANJI"];
//
//    [titleView addSubview:appIcon];
//    [titleView addSubview:title];
//
//    [[navBar topItem] setTitleView:titleView];
//
//}
