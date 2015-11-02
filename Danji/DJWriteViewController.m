//
//  DJWriteViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJWriteViewController.h"


@import MobileCoreServices;


@implementation DJWriteViewController
{
    __weak IBOutlet UITextField      *mInputFormPicker;
    __weak IBOutlet UITextField      *mCategoryPicker;
    __weak IBOutlet UITextField      *mTitle;
    __weak IBOutlet UITextField      *mCreator;
    __weak IBOutlet UICollectionView *mThumnailCollectionView;
    __weak IBOutlet UILabel          *mBody;
    
    NSArray                          *mImages;
    NSInteger                        mImageCount;
    NSArray                          *mInputForms;
    NSArray                          *mCategories;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPickerView];
    
    UITapGestureRecognizer *writeTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeLabelTapped:)];
    [mBody addGestureRecognizer:writeTapGesture];
    [mThumnailCollectionView setDelegate:self];
    [mThumnailCollectionView setDataSource:self];
    mImages = [[NSArray alloc] init];
    mImageCount = 0;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mInputFormPicker = nil;
    mCategoryPicker = nil;
    mInputForms = nil;
    mCategories = nil;
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"writeDialog"])
    {
        [[segue destinationViewController] setDialogDelegate:self];
    }
    else if([[segue identifier] isEqualToString:@"writhParagraph"])
    {
        [[segue destinationViewController] setParagraphDelegate:self];
    }
    else if([[segue identifier] isEqualToString:@"openGallery"])
    {
        [[segue destinationViewController] setImageDelegate:self];
    }
    
}


#pragma mark - action

- (IBAction)cancelButtonTapped:(id)sender
{
    
}

- (IBAction)doneButtonTapped:(id)sender
{
    //done
}

- (IBAction)writeLabelTapped:(id)sender
{
    if ([[mInputFormPicker text] isEqualToString:@"dialog"])
    {
        [self performSegueWithIdentifier:@"writeDialog" sender:self];

    }
    else if([[mInputFormPicker text] isEqualToString:@"paragraph"])
    {
        [self performSegueWithIdentifier:@"writhParagraph" sender:self];
    }
}

- (IBAction)cameraButtonTapped:(id)sender
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)galleryButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"openGallery" sender:self];
}


#pragma mark - image control

- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO || delegate == nil || controller == nil)
    {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [cameraUI setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]];
    [cameraUI setAllowsEditing:NO];
    [cameraUI setDelegate:delegate];
    
    [controller presentViewController:cameraUI animated:YES completion:NULL];
    
    return YES;
}

- (void)DJImagePickerController:(DJImagePickerController *)picker didFinishPickingImages:(NSArray *)images
{
    NSMutableArray *tempImages = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in images)
    {
        UIImage *image = [dictionary valueForKey:UIImagePickerControllerOriginalImage];
        [tempImages addObject:image];
    }
    
    mImages = [NSArray arrayWithArray:tempImages];
    
    [mThumnailCollectionView reloadData];
}


#pragma mark - collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [mImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJThumbnailCell *cell = [mThumnailCollectionView dequeueReusableCellWithReuseIdentifier:@"thumbnail" forIndexPath:indexPath];
    [cell setupThumbnail:[mImages objectAtIndex:[indexPath row]]];
    [cell setIndex:[indexPath row]];
    [cell setDelegate:self];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return YES;
}


#pragma mark - thumbnail cell delegate

- (void)thumbnailCellDidDeleted:(DJThumbnailCell *)cell
{
    NSMutableArray *tempImages = [[NSMutableArray alloc] init];
    tempImages = [NSMutableArray arrayWithArray:mImages];
    [tempImages removeObjectAtIndex:[cell index]];
    mImages = [NSArray arrayWithArray:tempImages];
    
    [mThumnailCollectionView reloadData];
}


#pragma mark - write delegate

- (void)dialogeWriteController:(DJDialogWriteController *)controller didFinishWriteCharacter:(NSArray *)caracters dialog:(NSArray *)dialogs
{
    
}

- (void)paragraphWriteController:(DJParagraphWriteController *)controller didFinishWriteParagraph:(NSString *)paragraph
{
    
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
    
    if (![[mInputFormPicker text] isEqualToString:@""] && ![[mCategoryPicker text] isEqualToString:@""])
    {
        [[self view] endEditing:YES];
    }
    
}


#pragma mark - setup


- (void)setupPickerView
{
    mInputForms = [[NSArray alloc] initWithObjects:@"dialog", @"paragraph", nil];
    mCategories = [[NSArray alloc] initWithObjects:@"movie", @"drama", @"book", @"poem", @"music", @"cartoon", nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor colorWithRed:0.74 green:0.82 blue:0.8 alpha:1]];
    
    [mInputFormPicker setInputView:pickerView];
    [mCategoryPicker setInputView:pickerView];
}


@end
