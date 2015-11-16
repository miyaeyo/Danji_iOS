//
//  DJWriteViewController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 12..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJDialogWriteController.h"
#import "DJParagraphWriteController.h"
#import "DJAlbumPickerController.h"
#import "DJThumbnailCell.h"


@interface DJWriteViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, DJDialogWriteDelegate, DJParagraphDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DJImagePickerControllerDelegate, UIImagePickerControllerDelegate, DJThumbnailCellDelegate, UIAlertViewDelegate>


@end
