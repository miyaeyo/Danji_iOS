//
//  DJSearchResultController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchDetailViewController.h"
#import "DJContentsViewCell.h"


@implementation DJSearchDetailViewController
{
    DJContentsViewCell  *mCell;
    DJContents          *mContents;
}

@synthesize contents = mContents;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewAttribute];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mCell = nil;
    mContents = nil;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchResult"];
    [mCell inputContents:mContents];
    
    return mCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!mCell)
    {
        mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchResult"];
    }
    [mCell inputContents:mContents];
    [mCell layoutIfNeeded];
    
    CGFloat height = [[mCell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark - setup

- (void)setupViewAttribute
{
    id navigationBar = [[self navigationController] navigationBar];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]}];
    
    [self setTitle:[mContents reference]];
    [[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
}


@end
