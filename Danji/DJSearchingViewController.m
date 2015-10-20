//
//  DJSearchingViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 20..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchingViewController.h"
#import "DJContents.h"
#import "DJSearchingViewCell.h"
#import "DJContentsManager.h"


@implementation DJSearchingViewController
{
    UISearchBar         *mSearchBar;
    DJSearchingViewCell *mCell;
    NSMutableArray      *mContentsList;
    NSString            *mSearchQuery;
    
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSearchBar];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    mContentsList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [mSearchBar removeFromSuperview];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJSearchingViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchList"];
    DJContents *contents = [mContentsList objectAtIndex:[indexPath row]];
    
    [cell inputTitle:[contents reference] body:[contents body]];
    
    return cell;
}


#pragma mark - search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //추천검색어 자동완성
    NSLog(@"search bar text did change");
    mSearchQuery = searchText;
    NSLog(@"%@", mSearchQuery);
    if ([searchText isEqualToString:@""])
    {
        NSLog(@"%@", mContentsList);
        [mContentsList removeAllObjects];
        [[self tableView] reloadData];
    }
    
    [self setupContentsManager];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //검색어 관련된 contents보여주는 view present
    
    NSLog(@"search bar search button clicked");
    [mContentsList removeAllObjects];
}


#pragma mark - contents manager delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishMakeAContents:(DJContents *)aContents
{
    int mark = 0;
    for (DJContents *contents in mContentsList)
    {
        if ([[contents reference] isEqualToString:[aContents reference]])
        {
            mark = 1;
        }
    }
    if (mark == 0)
    {
        [mContentsList addObject:aContents];
        [[self tableView] reloadData];
    }
}

#pragma mark - setup

- (void)setupSearchBar
{
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    CGFloat width = [navBar bounds].size.width - 70;
    CGFloat height = [navBar bounds].size.height;
    
    mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(80, 0, width - 20, height)];
    [mSearchBar setTranslucent:YES];
    [mSearchBar setBarTintColor:[UIColor colorWithRed:0.85 green:0.96 blue:0.9 alpha:1]];
    [mSearchBar setDelegate:self];
    
    [navBar addSubview:mSearchBar];
}

- (void)setupContentsManager
{
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager contentsFromParseDBWithBodyQuery:mSearchQuery];
    [contentsManager contentsFromParseDBWithTitleQuery:mSearchQuery];
    [contentsManager setDelegate:self];
}


@end
