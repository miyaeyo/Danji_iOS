//
//  DJSearchingViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 20..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchResultsController.h"
#import "DJContents.h"
#import "DJSearchResultsCell.h"
#import "DJContentsManager.h"
#import "DJSearchDetailViewController.h"


@implementation DJSearchResultsController
{
    UISearchBar         *mSearchBar;
    DJSearchResultsCell *mCell;
    NSMutableArray      *mContentsList;
    NSInteger           mSelectedIndex;
    NSString            *mSearchText;
}



#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewAttributes];
    
    mContentsList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mSearchBar = nil;
    mCell = nil;
    mContentsList = nil;
    mSearchText = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupSearchBar];
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
    mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchList"];
    DJContents *contents = [mContentsList objectAtIndex:[indexPath row]];
    
    [mCell inputTitle:[contents reference] body:[contents body] category:[contents category]];
    
    return mCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mSelectedIndex = [indexPath row];
    [self performSegueWithIdentifier:@"search" sender:self];
}

#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"search"])
    {
        id destinationController = [segue destinationViewController];
        [destinationController setContents:[mContentsList objectAtIndex:mSelectedIndex]];
    }
    
}


#pragma mark - search bar delegate

// reload data시점을 다시 생각해 볼 것
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    mSearchText = searchText;
    if ([searchText isEqualToString:@""])
    {
        [mContentsList removeAllObjects];
        [[self tableView] reloadData];
        return;
    }
    [self setupContentsManager];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mContentsList removeAllObjects];
    [[self tableView] reloadData];
    [self setupContentsManager];
}


#pragma mark - contents manager delegate

// DJContents manager로 부터 array를 넘겨 받는 형식으로 바꿀것.

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

- (void)setupViewAttributes
{
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

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

- (void)setupContentsManager// method명 모호
{
    //contentsManager를 singleton으로 만들것
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager contentsFromParseDBWithBodyQuery:mSearchText];
    [contentsManager contentsFromParseDBWithTitleQuery:mSearchText];
    [contentsManager setDelegate:self];
}


@end
