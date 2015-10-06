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
    
    UIView *titleView = [[UIView alloc] initWithFrame:[navBar bounds]];
    
    UIImageView *appIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danji.png"]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(28, 10, 100, 30)];
    [title setTextAlignment:NSTextAlignmentLeft];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont boldSystemFontOfSize:20.0]];
    [title setText:@"DANJI"];
    
    [titleView addSubview:appIcon];
    [titleView addSubview:title];
    
    [[navBar topItem] setTitleView:titleView];
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
