//
//  DJSearchViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchViewController.h"


@implementation DJSearchViewController


#pragma mark - view


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.99 green:0.95 blue:0.84 alpha:1]];
    
    [self setupNavigationBar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - private


- (void)setupNavigationBar
{
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    CGFloat width = [navBar bounds].size.width;
    CGFloat height = [navBar bounds].size.height;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, width - 20, height)];
    [searchBar setTranslucent:YES];
    [searchBar setBarTintColor:[UIColor colorWithRed:0.85 green:0.96 blue:0.9 alpha:1]];
    
    [navBar addSubview:searchBar];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
