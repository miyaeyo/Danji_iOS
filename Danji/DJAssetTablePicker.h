//
//  DJAssetTablePicker.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAsset.h"
#import "DJAssetSelectionDelegate.h"

@interface DJAssetTablePicker : UICollectionViewController <DJAssetDelegate>

@property (nonatomic, weak) id<DJAssetSelectionDelegate> delegate;


@end
