//
//  DJThumbnailCell.h
//  Danji
//
//  Created by miyaeyo on 2015. 11. 2..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJThumbnailCell;

@protocol DJThumbnailCellDelegate <NSObject>

@required
- (void)thumbnailCellDidDeleted:(DJThumbnailCell *)cell;

@end



@interface DJThumbnailCell : UICollectionViewCell

@property (nonatomic) NSInteger index;
@property (nonatomic, weak) id<DJThumbnailCellDelegate> delegate;

- (void)setupThumbnail:(UIImage *)image;



@end
