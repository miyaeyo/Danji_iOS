//
//  DJAlbumPickerController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DJAssetSelectionDelegate.h"

@class DJAlbumPickerController;
@protocol DJImagePickerControllerDelegate <UINavigationControllerDelegate>

@required

- (void)DJImagePickerController:(DJAlbumPickerController *)picker didFinishPickingImages:(NSArray *)images;

@end


@interface DJAlbumPickerController : UITableViewController <DJAssetSelectionDelegate>

@property (nonatomic, weak) id<DJImagePickerControllerDelegate> imageDelegate;

@end
