//
//  DJAssetPicker.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 31..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAsset.h"
#import "DJAssetSelectionDelegate.h"


@interface DJAssetPickerController : UICollectionViewController

@property (nonatomic, weak) id<DJAssetSelectionDelegate> pickerDelegate;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;

//- (void)setAssets:(NSArray *)assets;
//- (void)preparePhotos;

@end
