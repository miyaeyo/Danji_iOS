//
//  DJWriteViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJWriteViewController.h"


@implementation DJWriteViewController
{
    __weak IBOutlet UITextField *mInputFormPicker;
    __weak IBOutlet UITextField *mCategoryPicker;
    NSArray                     *mInputForms;
    NSArray                     *mCategories;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPickerView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mInputFormPicker = nil;
    mCategoryPicker = nil;
}


#pragma mark - action


- (IBAction)cancelButtonTapped:(id)sender
{
    //cancel
}


- (IBAction)doneButtonTapped:(id)sender
{
    //done
}


#pragma mark - picker view


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [mInputForms count];
    }
    else
    {
        return [mCategories count];
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [mInputForms objectAtIndex:row];
    }
    else
    {
        return [mCategories objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        [mInputFormPicker setText:[mInputForms objectAtIndex:row]];
    }
    else
    {
        [mCategoryPicker setText:[mCategories objectAtIndex:row]];
    }
}


#pragma mark - setup


- (void)setupPickerView
{
    mInputForms = [[NSArray alloc] initWithObjects:@"dialog", @"paragraph", nil];
    mCategories = [[NSArray alloc] initWithObjects:@"movie", @"drama", @"book", @"poem", @"music", @"cartoon", nil];
    
    
    UIPickerView *pickerView= [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor colorWithRed:0.74 green:0.82 blue:0.8 alpha:1]];
    [pickerView setTintColor:[UIColor whiteColor]];
    
    [mInputFormPicker setInputView:pickerView];
    [mCategoryPicker setInputView:pickerView];
}


@end
