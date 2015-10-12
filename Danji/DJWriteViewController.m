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
    NSArray *mInputForms;
    NSArray *mCategorys;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mInputForms = [[NSArray alloc] initWithObjects:@"dialog", @"paragraph", nil];
    
    
    UIPickerView *inputFormPicker = [[UIPickerView alloc] init];
    [inputFormPicker setDataSource:self];
    [inputFormPicker setDelegate:self];
    [inputFormPicker setShowsSelectionIndicator:YES];
    [mInputFormPicker setInputView:inputFormPicker];
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
    return [mInputForms count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mInputForms objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [mInputFormPicker setText:[mInputForms objectAtIndex:row]];
}





@end
