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
#import "UIColor+DanjiColor.h"


@implementation DJSearchResultsController
{
    UISearchBar         *mSearchBar;
    DJSearchResultsCell *mCell;
    NSMutableArray      *mContentsList;
    NSInteger           mSelectedIndex;
    NSString            *mSearchText;
    
    BOOL                mSearchBarEditting;
}

@synthesize searchBarEditting = mSearchBarEditting;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        mSearchBarEditting = NO;
    }
    
    return self;
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
    
    if ([self isViewLoaded])
    {
        mSearchBar = nil;
        mCell = nil;
        mContentsList = nil;
        mSearchText = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupSearchBar];
    
    if (mSearchBarEditting)
    {
        [mSearchBar becomeFirstResponder];
    }
    mSearchBarEditting = NO;
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    mSearchText = searchText;
    if ([searchText isEqualToString:@""])
    {
        [mContentsList removeAllObjects];
        [[self tableView] reloadData];
        return;
    }
    
    [self searchWithContentsManager];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mSearchBar endEditing:YES];
}


#pragma mark - contents manager delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishGetContentsList:(NSArray *)contentsList
{
    mContentsList = [NSMutableArray arrayWithArray:contentsList];
    [[self tableView] reloadData];
}


#pragma mark - setup

- (void)setupViewAttributes
{
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    [[self tableView] setBackgroundColor:[UIColor DJIvoryColor]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setupSearchBar
{
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    CGFloat width = [navBar bounds].size.width - 70;
    CGFloat height = [navBar bounds].size.height;
    
    mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(80, 0, width - 20, height)];
    [mSearchBar setTranslucent:YES];
    [mSearchBar setBarTintColor:[UIColor DJMintColor]];
    [mSearchBar setDelegate:self];
    
    [navBar addSubview:mSearchBar];
}

- (void)searchWithContentsManager
{
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager contentsFromParseDBWithSearchText:mSearchText];
    [contentsManager setDelegate:self];
}


@end
