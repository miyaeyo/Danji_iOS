//
//  DJAssetTablePicker.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAssetTablePicker.h"

@implementation DJAssetTablePicker
{
    __weak id<DJAssetSelectionDelegate> mDelegate;
    ALAssetsGroup *mAssetGroup;
    NSMutableArray *mAssets;
    BOOL singleSelection;
    BOOL immediateReturn;
}


#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mAssets = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    mDelegate = nil;
    mAssetGroup = nil;
    mAssets = nil;
    singleSelection = NULL;
    immediateReturn = NULL;
}


#pragma mark - collection view 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [mAssets count];
}

@end
