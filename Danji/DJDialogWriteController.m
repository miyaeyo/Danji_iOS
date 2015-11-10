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
   // __weak UIViewController<DJDialogWriteDelegate> *mDelegate;
    NSInteger                                      mFormCount;
    NSMutableArray                                 *mCharacter;
    NSMutableArray                                 *mDialog;
    
}

//@synthesize dialogDelegate = mDelegate;


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!mCharacter && !mDialog)
    {
        mFormCount = 1;
        mCharacter = [[NSMutableArray alloc] init];
        mDialog = [[NSMutableArray alloc] init];
        [mCharacter addObject:@""];
        [mDialog addObject:@""];
    }
    else
    {
        mFormCount = [mCharacter count];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Done"
                                message:@"Do you complete contents editing?"
                               delegate:self
                      cancelButtonTitle:@"NO"
                      otherButtonTitles:@"YES", nil] show];
}

- (IBAction)plusButtonTapped:(id)sender
{
    if ([[mCharacter objectAtIndex:(mFormCount-1)] isEqualToString:@""] || [[mDialog objectAtIndex:(mFormCount-1)] isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing some field"
                                    message:@"Please fill the empty field"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (mFormCount > 20)
    {
        [[[UIAlertView alloc] initWithTitle:@"Over maximun Form Count"
                                    message:@"You can add max 20 dialog form"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        return;
    }
    
    
    mFormCount ++;
    [mCharacter addObject:@""];
    [mDialog addObject:@""];
    
    [[self tableView] reloadData];
}


#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
       // [[self navigationController] popToViewController:mDelegate animated:YES];
       // [mDelegate dialogeWriteController:self didFinishWriteCharacter:mCharacter dialog:mDialog];
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
    [[cell character] setText:[mCharacter objectAtIndex:[indexPath row]]];
    [[cell dialog] setText:[mDialog objectAtIndex:[indexPath row]]];
    
    if (![[mDialog objectAtIndex:[indexPath row]] isEqualToString:@""])
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
        [mCharacter removeObjectAtIndex:[cell number]];
        [mDialog removeObjectAtIndex:[cell number]];
    }
    else
    {
        [mCharacter replaceObjectAtIndex:0 withObject:@""];
        [mDialog replaceObjectAtIndex:0 withObject:@""];
    }
    
    [[self tableView] reloadData];
}

- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingCharacter:(NSString *)character
{
    [mCharacter replaceObjectAtIndex:[cell number] withObject:character];
}

- (void)dialogInputCell:(DJDialogInputCell *)cell didEndEditingDialog:(NSString *)dialog
{
    [mDialog replaceObjectAtIndex:[cell number] withObject:dialog];
}


#pragma mark - edting

-(void)editingTextWithCharacters:(NSArray *)characters dialogs:(NSArray *)dialogs
{
    if ([characters count] != 0 && [dialogs count] != 0)
    {
        mCharacter = [NSMutableArray arrayWithArray:characters];
        mDialog = [NSMutableArray arrayWithArray:dialogs];
    }
}


@end
