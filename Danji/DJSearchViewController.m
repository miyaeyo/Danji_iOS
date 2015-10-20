//
//  DJSearchViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchViewController.h"
#import <Parse/Parse.h>
#import "Danji.h"


@implementation DJSearchViewController
{
    UISearchBar *mSearchBar;
    __weak IBOutlet UITableView *mTableView;
    NSArray *mPopularContentsList;
    NSString *mSearchQuery;
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mTableView setDelegate:self];
    [mTableView setDataSource:self];
    
    [self setupPopularContentsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mSearchBar = nil;
    mTableView = nil;
    mPopularContentsList = nil;
    mSearchQuery = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupSearchBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mSearchBar removeFromSuperview];
}


#pragma mark - popular contents delegate

- (void)popularContentsCell:(DJPopularContentsCell *)cell didContentsTapped:(NSString *)title
{
    mSearchQuery = title;
    [self performSegueWithIdentifier:@"popularContents" sender:self];
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"popularContents"])
    {
        id navigationBar = [segue destinationViewController];
        [navigationBar setTitle:[NSString stringWithFormat:@"검색: %@", mSearchQuery]];
    }
    
}


#pragma mark - searchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"text did begin editing");
    [self performSegueWithIdentifier:@"searchDetail" sender:self];
    
}


#pragma  mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mPopularContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJPopularContentsCell *cell = [mTableView dequeueReusableCellWithIdentifier:@"popularCell"];
    [cell setDelegate:self];
    
    [cell inputData:[mPopularContentsList objectAtIndex:[indexPath row]]
           withRank:[indexPath row] + 1];
    
    return cell;
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
    [mSearchBar setDelegate:self];
    
    [navBar addSubview:mSearchBar];
}

- (void)setupPopularContentsList
{
    PFQuery *query = [Danji query];
    [query orderByDescending:@"LikeCount"];
    [query setLimit:5];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
    {
        mPopularContentsList = [NSArray arrayWithArray:results];
        [mTableView reloadData];
    }];
    
}




@end








