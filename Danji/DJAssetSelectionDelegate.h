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


@protocol DJAssetSelectionDelegate <NSObject>

@required
- (void)selectedAssets:(NSArray *)assets;

@end


#endif
