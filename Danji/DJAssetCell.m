//
//  DJAssetCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 1..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAssetCell.h"

@implementation DJAssetCell
{
    __weak IBOutlet UIImageView *mPhoto;
}


#pragma mark - setup

- (void)setupAsset:(DJAsset *)aAsset
{
    [mPhoto setImage:[UIImage imageWithCGImage:[aAsset asset].thumbnail]];
}

@end
