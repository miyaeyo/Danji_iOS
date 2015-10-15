//
//  DJHomeViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJHomeViewController.h"
#import "DJHomeViewCell.h"
#import "DJContentsManager.h"


@implementation DJHomeViewController
{
    __weak IBOutlet UITextField *mCategory;
    NSArray                     *mCategories;
    DJHomeViewCell              *mCell;
    NSArray                     *mContentsList;
}


#pragma mark - view


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self tabBarController] tabBar] setTintColor:[UIColor whiteColor]];
    
    [self setupPickerView];
    
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    
    mContentsList = [NSArray arrayWithArray:[[[DJContentsManager alloc] init] contentsList]];
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


#pragma mark - pickerView

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


#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mContentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mCell = [[self tableView] dequeueReusableCellWithIdentifier:@"contentsCell"];
    
    return mCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calculate a height based on a cell
    DJHomeViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"contentsCell"];
    
    //Configure the cell
    [cell layoutIfNeeded];
    
    //Layout the cell
    CGFloat height = [[cell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    //Get the height for the cell
    
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


#pragma mark - setup

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
