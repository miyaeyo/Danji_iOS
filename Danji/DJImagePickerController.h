//
//  DJAlbumPickerController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DJAssetPickerController.h"


@class DJImagePickerController;
@protocol DJImagePickerControllerDelegate <UINavigationControllerDelegate>

@required

- (void)DJImagePickerController:(DJImagePickerController *)picker didFinishPickingImages:(NSArray *)images;

@end



@interface DJImagePickerController : UITableViewController <DJAssetPickerDelegate>

@property (nonatomic, weak) id<DJImagePickerControllerDelegate> imageDelegate;

@end
