//
//  DJAssetPicker.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 31..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAssetPickerController.h"
#import "DJAssetCell.h"
#import "DJAsset.h"


@implementation DJAssetPickerController
{
    __weak id<DJAssetPickerDelegate>    mDelegate;
    ALAssetsGroup                       *mAssetGroup;
    NSMutableArray                      *mAssets;
    NSUInteger                          mSelectionCount;
    NSUInteger                          mMaxSelectionCount;
}

@synthesize pickerDelegate = mDelegate;
@synthesize assetGroup = mAssetGroup;


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self collectionView] setDelegate:self];
    [[self collectionView] setDataSource:self];

    mAssets = [[NSMutableArray alloc] init];
    mMaxSelectionCount = 5;
    mSelectionCount = 0;
    
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preparePhotos) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        mDelegate = nil;
        mAssetGroup = nil;
        mAssets = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];

}


#pragma mark - collection view delegate

- (void)reloadCollectionView
{
    [[self collectionView] reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [mAssets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJAssetCell *cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    [cell setupAsset:[mAssets objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJAsset *asset = [mAssets objectAtIndex:[indexPath row]];
    [asset setSelected:![asset selected]];
    
    UICollectionViewCell *selectedCell = [[self collectionView] cellForItemAtIndexPath:indexPath];
    
    if ([asset selected] && mSelectionCount < mMaxSelectionCount)
    {
        mSelectionCount++;
        UIImageView *overlayView = [[UIImageView alloc] init];
        [overlayView setFrame:[selectedCell bounds]];
        [overlayView setImage:[UIImage imageNamed:@"overlay"]];
        
        [selectedCell addSubview:overlayView];
    }
    else if([asset selected] && mSelectionCount >= mMaxSelectionCount)
    {
        [[[UIAlertView alloc] initWithTitle:@"Over maximun selection"
                                    message:[NSString stringWithFormat:@"You can select maximun %ld photos", (unsigned long)mMaxSelectionCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    else
    {
        mSelectionCount--;
        [[[selectedCell subviews] objectAtIndex:1] removeFromSuperview];
    }
    
    return YES;
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^
    {
        NSMutableArray *selectedPhotos = [[NSMutableArray alloc] init];
        for (DJAsset *asset in mAssets)
        {
            if ([asset selected])
            {
                [selectedPhotos addObject:asset];
            }
        }
        
        [mDelegate selectedAssets:selectedPhotos];
    }];
}


#pragma mark - private

- (void)preparePhotos
{
    @autoreleasepool
    {
        [mAssets removeAllObjects];
        [mAssetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
        {
            if (result == nil)
            {
                return;
            }
            
            DJAsset *asset = [[DJAsset alloc] initWithAsset:result];
            [mAssets addObject:asset];
        }];
        
        [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:NO];
    }
}


@end



//#pragma mark - public
//
//- (void)setAssets:(NSArray *)assets
//{
//    [mAssets arrayByAddingObjectsFromArray:assets];
//}

