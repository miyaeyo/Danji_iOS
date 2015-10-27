//
//  DJAssetSelectionDelegate.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#ifndef Danji_DJAssetSelectionDelegate_h
#define Danji_DJAssetSelectionDelegate_h

#import <Foundation/Foundation.h>

@class DJAsset;

@protocol DJAssetSelectionDelegate <NSObject>

@required

- (void)selectedAssets:(NSArray *)assets;
- (BOOL)shouldSelectAsset:(DJAsset *)asset previousCount:(NSUInteger)previousCount;
- (BOOL)shouldDeselectAsset:(DJAsset *)asset previousCount:(NSUInteger)previousCount;

@end


#endif
