//
//  DJWriteViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJWriteViewController.h"
#import "DJContents.h"
#import "UIColor+DanjiColor.h"
#import "DJCategories.h"
#import "DJInputForms.h"


@import MobileCoreServices;


@implementation DJWriteViewController
{
    //storyboard
    __weak IBOutlet UITextField      *mInputFormPicker;
    __weak IBOutlet UITextField      *mCategoryPicker;
    __weak IBOutlet UITextField      *mTitle;
    __weak IBOutlet UITextField      *mCreator;
    __weak IBOutlet UICollectionView *mThumnailCollectionView;
    __weak IBOutlet UILabel          *mBody;
    __weak IBOutlet UILabel          *mBodyPlaceholder;
    
    NSArray                          *mImages;
    NSInteger                        mImageCount;
    NSArray                          *mCharacters;
    NSArray                          *mDialogs;
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPickerView];
    [self setupWriteRelatedTask];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![[mBody text]isEqualToString:@""])
    {
        [mBodyPlaceholder setText:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        mInputFormPicker = nil;
        mCategoryPicker = nil;
        mTitle = nil;
        mCreator = nil;
        mThumnailCollectionView = nil;
        mBody = nil;
        mBodyPlaceholder = nil;
        mImages = nil;
        mCharacters = nil;
        mDialogs = nil;
    }
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"writeDialog"])
    {
        DJDialogWriteController *destination = [segue destinationViewController];
        [destination setDialogDelegate:self];
        [destination editingTextWithCharacters:mCharacters dialogs:mDialogs];
    }
    else if([[segue identifier] isEqualToString:@"writhParagraph"])
    {
        DJParagraphWriteController *destination = [segue destinationViewController];
        [destination setParagraphDelegate:self];
        [destination setEditingText:[mBody text]];
        
    }
    if([[segue identifier] isEqualToString:@"openGallery"])
    {
        [[segue destinationViewController] setImageDelegate:self];
    }
}


#pragma mark - action

- (IBAction)cancelButtonTapped:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Cancel"
                                message:@"Do you really want to quit writing?"
                               delegate:self
                      cancelButtonTitle:@"NO"
                      otherButtonTitles:@"YES", nil] show];
}

- (IBAction)doneButtonTapped:(id)sender
{
    if ([[mTitle text] isEqualToString:@""] || [[mInputFormPicker text] isEqualToString:@""] || [[mCategoryPicker text] isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing some fields"
                                    message:@"Please fill the empty fields(title, input form, category).\n Only creator field is optional."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
                                                    message:@"Do you want to save this contents?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    
    [alert setTag:100];
    [alert show];
}

- (IBAction)writeLabelTapped:(id)sender
{
    [[self view] endEditing:YES];
    if ([[mInputFormPicker text] isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing input form and category field"
                                    message:@"Please select input form and categry"
                                   delegate:nil cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    else if ([[mInputFormPicker text] isEqualToString:@"dialog"])
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
    [self startCameraController];
}

- (IBAction)galleryButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"openGallery" sender:self];
}

- (IBAction)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}


#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([alertView tag] == 100)
        {
            [self saveParseDB];
        }
        
        [self performSegueWithIdentifier:@"complete" sender:self];
    }
}


#pragma mark - image control

- (BOOL)startCameraController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    [cameraUI setMediaTypes:[[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil]];
    [cameraUI setAllowsEditing:YES];
    [cameraUI setDelegate:self];
    
    [self presentViewController:cameraUI animated:YES completion:NULL];
    
    return YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    @autoreleasepool
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *originalImage, *editedImage, *imageToSave;
    
    editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (editedImage)
    {
        imageToSave = editedImage;
    }
    else
    {
        imageToSave = originalImage;
    }
    
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    mImages = [NSArray arrayWithObject:imageToSave];
    [mThumnailCollectionView reloadData];

    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (void)dialogeWriteController:(DJDialogWriteController *)controller didFinishWriteCharacter:(NSArray *)characters dialog:(NSArray *)dialogs
{
    NSMutableString *tempBody = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [characters count]; i++)
    {
        [tempBody appendFormat:@" %@: %@\n", [characters objectAtIndex:i], [dialogs objectAtIndex:i]];
    }
    
    [mBody setText:[NSString stringWithString:tempBody]];
    mCharacters = [NSArray arrayWithArray:characters];
    mDialogs = [NSArray arrayWithArray:dialogs];

}

- (void)paragraphWriteController:(DJParagraphWriteController *)controller didFinishWriteParagraph:(NSString *)paragraph
{
    [mBody setText:paragraph];
}


#pragma mark - picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView tag] == 0)
    {
        DJInputForms *inputForms = [[DJInputForms alloc] init];
        return [inputForms count];
    }
    else if([pickerView tag] == 1)
    {
        DJCategories *categories = [[DJCategories alloc] init];
        return [[categories categoriesForWrite] count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView tag] == 0)
    {
        DJInputForms *inputForms = [[DJInputForms alloc] init];
        return [inputForms inputFormAtIndex:row];
    }
    else if([pickerView tag] == 1)
    {
        DJCategories *categories = [[DJCategories alloc] init];
        return [[categories categoriesForWrite] objectAtIndex:row];
    }
    
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView tag] == 0)
    {
        DJInputForms *inputForms = [[DJInputForms alloc] init];
        [mInputFormPicker setText:[inputForms inputFormAtIndex:row]];
    }
    else if([pickerView tag] == 1)
    {
        DJCategories *categories = [[DJCategories alloc] init];
        [mCategoryPicker setText:[[categories categoriesForWrite] objectAtIndex:row]];
    }
    
    if (![[mInputFormPicker text] isEqualToString:@""] || ![[mCategoryPicker text] isEqualToString:@""])
    {
        [[self view] endEditing:YES];
    }
    
}


#pragma mark - private

- (void)setupPickerView
{
    UIPickerView *inputFormPickerView = [self makePickerViewWithTag:0];
    [mInputFormPicker setInputView:inputFormPickerView];
    
    UIPickerView *categoryPickerView = [self makePickerViewWithTag:1];
    [mCategoryPicker setInputView:categoryPickerView];
}

- (UIPickerView *)makePickerViewWithTag:(NSUInteger)tag
{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setTag:tag];
    [pickerView setBackgroundColor:[UIColor DJMintColor]];
    
    return pickerView;
}

- (void)setupWriteRelatedTask
{
    UITapGestureRecognizer *writeTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeLabelTapped:)];
    [mBody addGestureRecognizer:writeTapGesture];
    
    [mThumnailCollectionView setDelegate:self];
    [mThumnailCollectionView setDataSource:self];
    
    mImages = [[NSArray alloc] init];
    mImageCount = 0;
}


- (void)saveParseDB
{
    DJContents *contents = [DJContents object];
    [contents setUserName:[[PFUser currentUser] username]];
    [contents setCategory:[mCategoryPicker text]];
    [contents setTitle:[mTitle text]];
    [contents setCreator:[mCreator text]];
    [contents setBody:[mBody text]];
    [contents setImage:[self convertImages]];
    if ([[mCreator text] isEqualToString:@""]) {
        [contents setReference:[mTitle text]];
    }
    else
    {
        [contents setReference:[NSString stringWithFormat:@"%@ - %@ 中", [mTitle text], [mCreator text]]];
    }
    [contents setLikeCount:0];
    [contents setCharacter:mCharacters];
    [contents setDialog:mDialogs];
    [contents setImageHeight:[self imageSize].height];
    [contents setImageWidth:[self imageSize].width];
    
    [contents saveInBackground];
    
//    [contents saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
//    {
//        if (succeeded)
//        {
//            [self performSegueWithIdentifier:@"complete" sender:self];
//        }
//        else if (error)
//        {
//            NSLog(@"error: %@", [error description]);
//        }
//    }];
}

- (PFFile *)convertImages
{
    if ([mImages count] == 1)
    {
        NSData *imageData = UIImagePNGRepresentation([mImages firstObject]);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        return imageFile;
    }
    else
    {
        CGSize mergeSize = [self imageSize];
        
        UIGraphicsBeginImageContext(mergeSize);
        CGFloat prevHeight = 0.0f;
        for (UIImage *image in mImages)
        {
            [image drawInRect:CGRectMake(0, prevHeight, mergeSize.width, image.size.height)];
            prevHeight += image.size.height;
        }
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(finalImage);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        return imageFile;
    }
    
}

- (CGSize)imageSize
{
    if ([mImages count] == 1)
    {
        return [[mImages firstObject] bounds].size;
    }
    else
    {
        CGFloat height = 0.0f;
        UIImage *firstImage = [mImages firstObject];
        CGFloat width = firstImage.size.width;
        
        for (UIImage *image in mImages)
        {
            height += image.size.height;
        }
        
        return CGSizeMake(width, height);
    }
}


@end
