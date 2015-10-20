//
//  DJSearchResultController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchResultController.h"
#import "DJContentsViewCell.h"


@implementation DJSearchResultController
{
    NSString *mQuery;
    DJContentsViewCell          *mCell;
    NSMutableArray              *mContentsList;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupQuery];
    [self setupViewAttribute];
    [self setupContentsManager];
    
    mContentsList = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mQuery = nil;
    mCell = nil;
    mContentsList = nil;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchResult"];
    [mCell inputContents:[mContentsList objectAtIndex:[indexPath row]]];
    
    return mCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!mCell)
    {
        mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchResult"];
    }
    [mCell inputContents:[mContentsList objectAtIndex:[indexPath row]]];
    [mCell layoutIfNeeded];
    
    CGFloat height = [[mCell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark - contents manager delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishMakeAContents:(DJContents *)aContents
{
    DJContents *contents = [DJContents contentsWithImage:[aContents image]
                                                    body:[aContents body]
                                               reference:[aContents reference]
                                               likeCount:[aContents likeCount]];
    
    [mContentsList addObject:contents];
    [[self tableView] reloadData];
}


#pragma mark - setup

- (void)setupQuery
{
    NSString *title = [[[self navigationController] topViewController] title];
    NSArray *tempQuery = [title componentsSeparatedByString:@"검색: "];
    mQuery = [tempQuery objectAtIndex:1];
}

- (void)setupViewAttribute
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]}];
    [[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
}

- (void)setupContentsManager
{
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager setDelegate:self];
    [contentsManager contentsFromParseDBWithQuery:mQuery];
}



@end
