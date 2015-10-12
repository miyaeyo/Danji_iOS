//
//  DJSearchViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchViewController.h"


@implementation DJSearchViewController
{
    UISearchBar *mSearchBar;
}


#pragma mark - view


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSearchBar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


 #pragma mark - setup


 - (void)setupSearchBar
 {
     UINavigationBar *navBar = [[self navigationController] navigationBar];
     CGFloat width = [navBar bounds].size.width;
     CGFloat height = [navBar bounds].size.height;

     mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, width - 20, height)];
     [mSearchBar setTranslucent:YES];
     [mSearchBar setBarTintColor:[UIColor colorWithRed:0.85 green:0.96 blue:0.9 alpha:1]];

     [navBar addSubview:mSearchBar];
 }



@end








