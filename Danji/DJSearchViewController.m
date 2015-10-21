//
//  DJSearchViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchViewController.h"
#import "DJPopularContentsCell.h"



@implementation DJSearchViewController
{
    UISearchBar *mSearchBar;
    __weak IBOutlet UITableView *mTableView;
    NSMutableArray *mPopularContentsList;
    NSInteger mSelectedIndex;
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mTableView setDelegate:self];
    [mTableView setDataSource:self];
    
    mPopularContentsList = [[NSMutableArray alloc] init];
    
    [self setupPopularContentsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mSearchBar = nil;
    mTableView = nil;
    mPopularContentsList = nil;
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


#pragma mark - contents delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishMakeAContents:(DJContents *)aContents
{
    [mPopularContentsList addObject:aContents];
    if ([mPopularContentsList count] == 5)
    {
        [mTableView reloadData];
    }
}



#pragma mark - searchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
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
    [cell inputData:[mPopularContentsList objectAtIndex:[indexPath row]]
           withRank:[indexPath row] + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mSelectedIndex = [indexPath row];
    [self performSegueWithIdentifier:@"popularContents" sender:self];
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"popularContents"])
    {
        id destinationController = [segue destinationViewController];
        [destinationController setContents:[mPopularContentsList objectAtIndex:mSelectedIndex]];
        
    }
    
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
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager setDelegate:self];
    [contentsManager contentsFromParseDBWithLikeCount:5];
}


@end








