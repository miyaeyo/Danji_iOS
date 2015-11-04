//
//  DJHomeViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJHomeViewController.h"
#import "DJContentsViewCell.h"
#import "DJContentsManager.h"
#import "DJContents.h"


@implementation DJHomeViewController
{
    __weak IBOutlet UITextField *mCategory;
    NSArray                     *mCategories;
    DJContentsViewCell          *mCell;
    NSArray              *mContentsList;
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewAttributes];
    [self getContentsFromDB];
    [self setupPickerView];
    
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mCategories = nil;
    mCategory = nil;
    mCell = nil;
    mContentsList = nil;
    
}


#pragma mark - action

- (IBAction)logoutButtonTapped:(id)sender
{
    [PFUser logOut];
}


#pragma mark - picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mCategories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mCategories objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [mCategory setText:[mCategories objectAtIndex:row]];
    [[self view] endEditing:YES];
}


#pragma mark - table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"number of rows in section");

    return [mContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for index path");
    mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"contentsCell"];
    [mCell inputContents:[mContentsList objectAtIndex:[indexPath row]]];
    
    return mCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"height for row at index path");
    
    if (!mCell)
    {
        mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"contentsCell"];
    }
    [mCell inputContents:[mContentsList objectAtIndex:[indexPath row]]];
    [mCell layoutIfNeeded];
    
    CGFloat height = [[mCell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"estimated height for row at index path");
    return 200;
}


#pragma mark - contents delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishGetContentsList:(NSArray *)contentsList
{
    mContentsList = [NSArray arrayWithArray:contentsList];
    [[self tableView] reloadData];
}


#pragma mark - setup

- (void)setupViewAttributes
{
    [[[self tabBarController] tabBar] setTintColor:[UIColor whiteColor]];
    [[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
}

- (void)getContentsFromDB
{
    DJContentsManager *contentsManager = [[DJContentsManager alloc] init];
    [contentsManager setDelegate:self];
    [contentsManager contentsFromParseDB];
}

- (void)setupPickerView
{
    mCategories = [[NSArray alloc] initWithObjects: @"TOTAL", @"MOVIE", @"DRAMA", @"BOOK", @"POEM", @"MUSIC", @"CARTOON", nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor colorWithRed:0.74 green:0.82 blue:0.8 alpha:1]];
    
    [mCategory setInputView:pickerView];
}


@end




//- (void)setupNavigationBar
//{
//    UINavigationBar *navBar = [[self navigationController] navigationBar];
//    UIView *titleView = [[UIView alloc] initWithFrame:[navBar bounds]];
//
//    UIImageView *appIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danji.png"]];
//    [appIcon setFrame:CGRectMake(0, 0, [appIcon bounds].size.width, [navBar bounds].size.height)];
//
//    UILabel *title = [[UILabel alloc] initWithFrame:[navBar bounds]];
//    [title setTextAlignment:NSTextAlignmentCenter];
//    [title setTextColor:[UIColor colorWithRed:0.98 green:0.95 blue:0.84 alpha:1]];
//    [title setFont:[UIFont boldSystemFontOfSize:20.0]];
//    [title setText:@"DANJI"];
//
//    [titleView addSubview:appIcon];
//    [titleView addSubview:title];
//
//    [[navBar topItem] setTitleView:titleView];
//
//}
