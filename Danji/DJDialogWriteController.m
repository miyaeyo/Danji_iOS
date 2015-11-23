//
//  DJDialogWriteController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJDialogWriteController.h"


@implementation DJDialogWriteController
{
    __weak UIViewController<DJDialogWriteDelegate> *mDelegate;
    NSInteger                                      mFormCount;
    NSMutableArray                                 *mCharacters;
    NSMutableArray                                 *mDialogs;
    NSUInteger                                     mTextByte;
}

@synthesize dialogDelegate = mDelegate;


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!mCharacters && !mDialogs)
    {
        mTextByte = 0;
        mFormCount = 1;
        mCharacters = [[NSMutableArray alloc] init];
        mDialogs = [[NSMutableArray alloc] init];
        [mCharacters addObject:@""];
        [mDialogs addObject:@""];
    }
    else
    {
        mFormCount = [mCharacters count];
        
        for (int i = 0; i < mFormCount; i++)
        {
            mTextByte += ([[mCharacters objectAtIndex:i] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]
                          + [[mDialogs objectAtIndex:i] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    [[self navigationController] popToViewController:mDelegate animated:YES];
    [mDelegate dialogeWriteController:self didFinishWriteCharacter:mCharacters dialog:mDialogs];
}

- (IBAction)plusButtonTapped:(id)sender
{
    if ([[mCharacters objectAtIndex:(mFormCount - 1)] isEqualToString:@""] || [[mDialogs objectAtIndex:(mFormCount - 1)] isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing some field"
                                    message:@"Please fill the empty field"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        return;
    }
    else
    {
        mTextByte += ([[mCharacters objectAtIndex:(mFormCount - 1)] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]
                      + [[mDialogs objectAtIndex:(mFormCount - 1)] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        
        NSLog(@"text byte: %ld", (unsigned long)mTextByte);     //parse object size limit 128kb
        if (mTextByte > 127000)
        {
            [[[UIAlertView alloc] initWithTitle:@"Over maximun contents length"
                                        message:@"Text should be less than 128KB"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil] show];
            return;
        }
       
        mFormCount ++;
        [mCharacters addObject:@""];
        [mDialogs addObject:@""];
        
        [[self tableView] reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mFormCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)[indexPath row]);
    DJDialogInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dialog" forIndexPath:indexPath];
    [cell setNumber:[indexPath row]];
    [cell setDelegate:self];
    [[cell dialog] setDelegate:cell];
    [[cell character] setText:[mCharacters objectAtIndex:[indexPath row]]];
    [[cell dialog] setText:[mDialogs objectAtIndex:[indexPath row]]];
    
    if (![[mDialogs objectAtIndex:[indexPath row]] isEqualToString:@""])
    {
        [[cell dialogPlaceholder] setText:@""];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self view] endEditing:YES];
}

#pragma mark - input cell delegate

- (void)dialogInputCellDidDeleted:(DJDialogInputCell *)cell
{
    if (mFormCount != 1)
    {
        mFormCount--;
        mTextByte -= ([[mCharacters objectAtIndex:[cell number]] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]
                      + [[mDialogs objectAtIndex:[cell number]] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        [mCharacters removeObjectAtIndex:[cell number]];
        [mDialogs removeObjectAtIndex:[cell number]];
    }
    else
    {
        mTextByte = 0;
        [mCharacters replaceObjectAtIndex:0 withObject:@""];
        [mDialogs replaceObjectAtIndex:0 withObject:@""];
    }
    
    [[self tableView] reloadData];
}

- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingCharacter:(NSString *)character
{
    [mCharacters replaceObjectAtIndex:[cell number] withObject:character];
}

- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingDialog:(NSString *)dialog
{
    [mDialogs replaceObjectAtIndex:[cell number] withObject:dialog];
}


#pragma mark - edting

-(void)editingTextWithCharacters:(NSArray *)characters dialogs:(NSArray *)dialogs
{
    if ([characters count] != 0 && [dialogs count] != 0)
    {
        mCharacters = [NSMutableArray arrayWithArray:characters];
        mDialogs = [NSMutableArray arrayWithArray:dialogs];
    }
}


@end
