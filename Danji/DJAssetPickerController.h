//
//  DJAssetPicker.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 31..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAsset.h"


@protocol DJAssetPickerDelegate <NSObject>

@required
- (void)selectedAssets:(NSArray *)assets;

@end


@interface DJAssetPickerController : UICollectionViewController

@property (nonatomic, weak) id<DJAssetPickerDelegate> pickerDelegate;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;

@end
