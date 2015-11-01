//
//  DJAssetPicker.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 31..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAssetPicker.h"
#import "DJAssetCell.h"


@implementation DJAssetPicker
{    
    __weak id<DJAssetSelectionDelegate> mDelegate;
    ALAssetsGroup                       *mAssetGroup;
    NSMutableArray                      *mAssets;
}

@synthesize delegate = mDelegate;
@synthesize assetGroup = mAssetGroup;

static NSString * const reuseIdentifier = @"photoCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self collectionView] setDelegate:self];
    [[self collectionView] setDataSource:self];

    mAssets = [[NSMutableArray alloc] init];
    
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preparePhotos) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];

}


#pragma mark <UICollectionViewDataSource>

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
    DJAssetCell *cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setupAsset:[mAssets objectAtIndex:[indexPath row]]];
    [cell sizeToFit];
    
    return cell;
}


#pragma mark - asset delegate

- (void)assetSelected:(DJAsset *)asset
{
    
}

- (BOOL)shouldSelectAsset:(DJAsset *)asset
{
    NSUInteger selectionCount = 0;
    for (DJAsset *asset in mAssets)
    {
        if ([asset selected])
        {
            selectionCount++;
        }
    }
    
    BOOL shouldSelect = YES;
    
    if ([mDelegate respondsToSelector:@selector(shouldSelectAsset:previousCount:)])
    {
        shouldSelect = [mDelegate shouldSelectAsset:asset previousCount:selectionCount];
    }
    
    return shouldSelect;
}

- (void)assetDeselected:(DJAsset *)asset
{
    
}

- (BOOL)shouldDeselectAsset:(DJAsset *)asset
{
    return YES;
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    NSMutableArray *selectedPhotos = [[NSMutableArray alloc] init];
    for (DJAsset *asset in mAssets)
    {
        if ([asset selected])
        {
            [selectedPhotos addObject:asset];
        }
        
        [mDelegate selectedAssets:selectedPhotos];
    }
}


#pragma mark - public

- (void)setAssets:(NSArray *)assets
{
    [mAssets arrayByAddingObjectsFromArray:assets];
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
            [asset setDelegate:self];
            
            [mAssets addObject:asset];
        }];
        
        [[self collectionView] reloadData];
    }
}


#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
