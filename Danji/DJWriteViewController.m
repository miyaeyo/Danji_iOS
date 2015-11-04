//
//  DJWriteViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJWriteViewController.h"
#import "DJContents.h"


@import MobileCoreServices;


@implementation DJWriteViewController
{
    __weak IBOutlet UITextField      *mInputFormPicker;
    __weak IBOutlet UITextField      *mCategoryPicker;
    __weak IBOutlet UITextField      *mTitle;
    __weak IBOutlet UITextField      *mCreator;
    __weak IBOutlet UICollectionView *mThumnailCollectionView;
    __weak IBOutlet UILabel          *mBody;
    __weak IBOutlet UILabel          *mBodyPlaceholder;
    
    NSArray                          *mImages;
    NSInteger                        mImageCount;
    NSArray                          *mInputForms;
    NSArray                          *mCategories;
    NSArray                          *mCharacters;
    NSArray                          *mDialogs;
    
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
    else if([[segue identifier] isEqualToString:@"openGallery"])
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
        [[[UIAlertView alloc] initWithTitle:@"some fields(title, input form, category) are empty"
                                    message:@"Please fill the empty fields"
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

- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO || delegate == nil || controller == nil)
    {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [cameraUI setMediaTypes:[[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil]];
    [cameraUI setAllowsEditing:YES];
    [cameraUI setDelegate:delegate];
    
    [controller presentViewController:cameraUI animated:YES completion:NULL];
    
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


#pragma mark - private


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

- (void)saveParseDB
{
    DJContents *contents = [DJContents object];
    [contents setUserName:[[PFUser currentUser] username]];
    [contents setCategory:[mCategoryPicker text]];
    [contents setTitle:[mTitle text]];
    [contents setCreator:[mCreator text]];
    [contents setBody:[mBody text]];
    [contents setImage:[self convertImages:mImages]];
    if ([[mCreator text] isEqualToString:@""]) {
        [contents setReference:[mTitle text]];
    }
    else
    {
        [contents setReference:[NSString stringWithFormat:@"%@ - %@", [mTitle text], [mCreator text]]];
    }
    [contents setLikeCount:0];
    [contents setCharacter:mCharacters];
    [contents setDialog:mDialogs];
    
    [contents saveInBackground];
}

- (PFFile *)convertImages:(NSArray *)images
{
    
    if ([images count] == 1)
    {
        NSData *imageData = UIImagePNGRepresentation([images firstObject]);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        
        return imageFile;
    }
    else
    {
        CGFloat height = 0.0f;
        UIImage *firstImage = [images firstObject];
        CGFloat width = firstImage.size.width;
        
        for (UIImage *image in images)
        {
            height += image.size.height;
        }
        
        CGSize size = CGSizeMake(width, height);
        
        UIGraphicsBeginImageContext(size);
        
        CGFloat prevHeight = 0.0f;
        
        for (UIImage *image in images)
        {
            [image drawInRect:CGRectMake(0, prevHeight, width, image.size.height)];
            prevHeight += image.size.height;
        }
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(finalImage);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        return imageFile;
    }
    
}




@end
