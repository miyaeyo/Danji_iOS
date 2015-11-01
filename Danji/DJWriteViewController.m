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
    NSArray                          *mInputForms;
    NSArray                          *mCategories;
    __weak IBOutlet UITextField      *mTitle;
    __weak IBOutlet UITextField      *mCreator;
    __weak IBOutlet UICollectionView *mThumnailCollection;
    __weak IBOutlet UILabel          *mBody;
    NSMutableArray                   *mImages;
    NSInteger                        mImageCount;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPickerView];
    
    UITapGestureRecognizer *writeTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeLabelTapped:)];
    [mBody addGestureRecognizer:writeTapGesture];
    [mThumnailCollection setDelegate:self];
    [mThumnailCollection setDataSource:self];
    mImages = [[NSMutableArray alloc] initWithCapacity:5];
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


#pragma mark - collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [mImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [mThumnailCollection dequeueReusableCellWithReuseIdentifier:@"thumbnail" forIndexPath:indexPath];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo"]]];
    
    return cell;
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

/*
 - (BOOL)startGalleryControllerFromViewController:(UIViewController *)controller usingDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate
 {
 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO || delegate == nil || controller == nil)
 {
 return NO;
 }
 
 UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
 [mediaUI setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
 
 //[mediaUI setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]];
 
 [mediaUI setMediaTypes:[[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil]];
 [mediaUI setAllowsEditing:NO];
 [mediaUI setDelegate:delegate];
 
 
 [controller presentViewController:mediaUI animated:YES completion:NULL];
 
 
 return YES;
 }
 
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
 NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
 UIImage *originalImage, *editedImage, *imageToUse;
 mImageCount++;
 
 
 
 
 if (mImageCount >5)
 {
 [[[UIAlertView alloc] initWithTitle:@"Notice"
 message:@"You can select maximum 5 photos"
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil, nil] show];
 [mImages removeLastObject];
 return;
 }
 
 if (CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
 {
 editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
 originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
 
 if (editedImage)
 {
 imageToUse = editedImage;
 }
 else
 {
 imageToUse = originalImage;
 }
 [mImages addObject:imageToUse];
 NSLog(@"%lu", (unsigned long)[mImages count]);
 NSLog(@"%@", imageToUse);
 }
 
 [[picker parentViewController] dismissViewControllerAnimated:YES completion:NULL];
 }
 */

