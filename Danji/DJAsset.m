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
    BOOL mSelected;
}

@synthesize selected = mSelected;
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

@end
