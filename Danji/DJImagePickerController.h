//
//  DJImagePicker.h
//  Danji
//
//  Created by miyaeyo on 2015. 11. 2..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAssetSelectionDelegate.h"


@class DJAlbumPickerController;
@class DJImagePickerController;

@protocol DJImagePickerControllerDelegate <UINavigationControllerDelegate>

@required

- (void)DJImagePickerController:(DJImagePickerController *)picker didFinishPickingImages:(NSArray *)images;

@end


@interface DJImagePickerController : UINavigationController <DJAssetSelectionDelegate>

@property (nonatomic, weak) id<DJImagePickerControllerDelegate> imageDelegate;

@end
