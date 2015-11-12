//
//  DJAlbumPickerController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "DJAssetSelectionDelegate.h"

@interface DJAlbumPickerController : UITableViewController <DJAssetSelectionDelegate>

@property (nonatomic, weak) id<DJAssetSelectionDelegate> delegate;



@end
