//
//  DJAsset.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface DJAsset : NSObject

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, readonly) ALAsset *asset;

- (id)initWithAsset:(ALAsset *)asset;

@end
