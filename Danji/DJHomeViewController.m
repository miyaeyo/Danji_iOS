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
#import "DJCategories.h"
#import "UIColor+DanjiColor.h"


@implementation DJHomeViewController
{
    UITextField        *mCategory;
    NSArray            *mContentsList;
    DJContentsManager  *mContentsManager;
    
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewAttributes];
    [self setupContentsManager];
    [self setupPickerView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded])
    {
        mCategory = nil;
        mContentsList = nil;
        mContentsManager = nil;
    }
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
    CGFloat height = [self estimateCellHeightWithContents:[mContentsList objectAtIndex:[indexPath row]]];
    
    return height + 5;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return mCategory;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    //category selection view height
//    return 35;
//}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dummy data for estimate row height
    return 700;
}


#pragma mark - contents delegate

- (void)contentsManager:(DJContentsManager *)aContentsManager didFinishGetContentsList:(NSArray *)contentsList
{
    @autoreleasepool
    {
        mContentsList = [NSArray arrayWithArray:contentsList];
        if ([[self refreshControl] isRefreshing])
        {
            [self setupPickerView];
            [[self refreshControl] endRefreshing];
        }
        [[self tableView] reloadData];
        
    }
}


#pragma mark - action

- (IBAction)logoutButtonTapped:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Logout"
                                message:@"Do you want to logout Danji?"
                               delegate:self
                      cancelButtonTitle:@"NO"
                      otherButtonTitles:@"YES", nil] show];
}


#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) // logout
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
    DJCategories *categories = [[DJCategories alloc] init];
    
    return [[categories categories] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DJCategories *categories = [[DJCategories alloc] init];
    
    return [[[categories categories] objectAtIndex:row] capitalizedString];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    DJCategories *categories = [[DJCategories alloc] init];
    [mCategory setText:[[[categories categories] objectAtIndex:row] capitalizedString]];
    [[self view] endEditing:YES];
    
    [mContentsManager contentsFromParseDBWithCategory:[[mCategory text] lowercaseString]];
}


#pragma mark - setup

- (void)setupViewAttributes
{
    [[[self tabBarController] tabBar] setTintColor:[UIColor whiteColor]];
    [[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh setBackgroundColor:[UIColor DJIvoryColor]];
    [refresh setTintColor:[UIColor DJMintColor]];
    [refresh addTarget:self action:@selector(setupContentsManager) forControlEvents:UIControlEventAllEvents];
    [self setRefreshControl:refresh];
    
}

- (void)setupContentsManager
{
    mContentsManager = [[DJContentsManager alloc] init];
    [mContentsManager setDelegate:self];
    [mContentsManager contentsFromParseDB];
}

- (void)setupPickerView
{
    mCategory = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[self view] bounds].size.width, 35)];
    [mCategory setBackgroundColor:[UIColor DJIvoryColor]];
    [mCategory setTextColor:[UIColor DJBrownColor]];
    [mCategory setFont:[UIFont boldSystemFontOfSize:17]];
    [mCategory setTextAlignment:NSTextAlignmentCenter];
    [mCategory setPlaceholder:@"CATEGORY"];
    [mCategory setClearButtonMode:UITextFieldViewModeNever];
    [[self tableView] addSubview:mCategory];
    

    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor DJMintColor]];
    
    [mCategory setInputView:pickerView];
}




#pragma mark - private

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
    
    return imageHeight + bodyHeight + 60;
}


@end

