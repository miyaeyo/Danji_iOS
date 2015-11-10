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
    
    mContents = nil;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJContentsViewCell  *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"searchResult"];
    [cell inputContents:mContents];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self estimateCellHeightWithContents:mContents];
    
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
    
    [self setTitle:[mContents title]];
    [[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
}

- (CGFloat)estimateCellHeightWithContents:(DJContents *)contents
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat imageHeight = [contents imageHeight] * screenSize.width / [contents imageWidth];
    UILabel *body = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenSize.width - 20, 0)];
    [body setNumberOfLines:0];
    [body setLineBreakMode:NSLineBreakByWordWrapping];
    [body setText:[contents body]];
    [body setFont:[UIFont systemFontOfSize:13]];
    [body sizeToFit];
    CGFloat bodyHeight = [body bounds].size.height;
    
    return imageHeight + bodyHeight + 50;
}







@end
