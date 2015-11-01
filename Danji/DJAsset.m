//
//  DJAsset.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAsset.h"

@implementation DJAsset
{
    ALAsset *mAsset;
    __weak id<DJAssetDelegate> mDelegate;
    BOOL mSelected;
    NSInteger mIndex;
}

@synthesize selected = mSelected;
@synthesize delegate = mDelegate;
@synthesize index = mIndex;
@synthesize asset = mAsset;

- (instancetype)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    
    if (self)
    {
        mAsset = asset;
        mSelected = NO;
    }
    
    return self;
}


#pragma mark - public

- (NSComparisonResult)compareWithIndex:(DJAsset *)asset
{
    if (mIndex > [asset index])
    {
        return NSOrderedDescending;
    }
    else if (mIndex < [asset index])
    {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}


#pragma mark - select

- (void)toggleSelection
{
    mSelected = !mSelected;
}

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        if ([mDelegate respondsToSelector:@selector(shouldSelectAsset:)])
        {
            if (![mDelegate shouldSelectAsset:self])
            {
                return;
            }
        }
    }
    else
    {
        if ([mDelegate respondsToSelector:@selector(shouldDeselectAsset:)])
        {
            if (![mDelegate shouldDeselectAsset:self])
            {
                return;
            }
        }
    }
    
    mSelected = selected;
    
    if (selected)
    {
        if (mDelegate != nil && [mDelegate respondsToSelector:@selector(assetSelected:)])
        {
            [mDelegate assetSelected:self];
        }
    }
    else
    {
        if (mDelegate != nil && [mDelegate respondsToSelector:@selector(assetDeselected:)])
        {
            [mDelegate assetDeselected:self];
        }
    }
}










@end
