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
    NSArray                     *mContentsList;
    DJContentsManager           *mContentsManager;
    
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewAttributes];
    [self setupPickerView];
    
    
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getContentsFromDB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded])
    {
        mCategories = nil;
        mCategory = nil;
        mContentsList = nil;
    }
}


#pragma mark - action

- (IBAction)logoutButtonTapped:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Logout"
                                message:@"Do you want to logout Danji?"
                               delegate:self cancelButtonTitle:@"NO"
                      otherButtonTitles:@"YES", nil] show];
}


#pragma mark - aler view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"logout" sender:self];
    }
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
    return [mContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJContentsViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"contentsCell"];
    [cell inputContents:[mContentsList objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    DJContents *cellContents = [mContentsList objectAtIndex:[indexPath row]];
    CGFloat imageHeight = [cellContents imageHeight] * screenSize.width / [cellContents imageWidth];
    UILabel *body = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenSize.width - 10, 0)];
    [body setText:[cellContents body]];
    [body sizeToFit];
    CGFloat bodyHeight = [body bounds].size.height;
    NSLog(@"- %ld image: %lf body: %lf", [indexPath row], imageHeight, bodyHeight);
    
    CGFloat height = imageHeight + bodyHeight + 50;
    //CGFloat height = [cell height];
    //CGFloat height = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    NSLog(@"- %ld height : %lf", (long)[indexPath row], height);
    return height + 5;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 700;
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
    mContentsManager = [[DJContentsManager alloc] init];
    [mContentsManager setDelegate:self];
    [mContentsManager contentsFromParseDB];
}

- (void)setupPickerView // category class로 빼기
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

