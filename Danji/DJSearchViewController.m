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
    NSString *mPopularContentsTitle;
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
    mPopularContentsTitle = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupSearchBar];
}


#pragma mark - popular contents delegate

- (void)popularContentsCell:(DJPopularContentsCell *)cell didContentsTapped:(NSString *)title
{
    mPopularContentsTitle = title;
    [self performSegueWithIdentifier:@"popularContents" sender:self];
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [mSearchBar removeFromSuperview];
    
    if ([[segue identifier] isEqualToString:@"popularContents"])
    {
        id navigationBar = [segue destinationViewController];
        [navigationBar setTitle:[NSString stringWithFormat:@"검색: %@", mPopularContentsTitle]];
    }
    
}


#pragma mark - searchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"text did begin editing");
    [self performSegueWithIdentifier:@"searchDetail" sender:self];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"search bar text did end editting");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search bar text did change");
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //검색어 관련된 contents보여주는 view present
    
    NSLog(@"search bar search button clicked");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // pop 자동검색어 view
    NSLog(@"search bar cancel button clicked");
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








