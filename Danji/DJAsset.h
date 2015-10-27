//
//  DJAsset.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@class DJAsset;

@protocol DJAssetDelegate <NSObject>

@optional
- (void)assetSelected:(DJAsset *)asset;
- (BOOL)shouldSelectAsset:(DJAsset *)asset;
- (void)assetDeselected:(DJAsset *)asset;
- (BOOL)shouldDeselectAsset:(DJAsset *)asset;

@end


@interface DJAsset : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, weak) id<DJAssetDelegate> delegate;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger index;

- (id)initWithAsset:(DJAsset *)asset;
- (NSComparisonResult)compareWithIndex:(DJAsset *)asset;

@end
