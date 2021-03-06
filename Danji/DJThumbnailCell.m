//
//  DJThumbnailCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 2..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJThumbnailCell.h"

@implementation DJThumbnailCell
{
    __weak IBOutlet UIImageView         *mThumbnailView;
    NSInteger                           mIndex;
    __weak id<DJThumbnailCellDelegate>  mDelegate;
}

@synthesize index = mIndex;
@synthesize delegate = mDelegate;


- (void)setupThumbnail:(UIImage *)image
{
    UIImage *original = image;
    CGSize thumbnailViewSize = [mThumbnailView bounds].size;
    CGSize newSize = CGSizeMake(thumbnailViewSize.width, thumbnailViewSize.height);
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [mThumbnailView setImage:resized];
}

- (IBAction)deleteButtonTapped:(id)sender
{
    [mDelegate thumbnailCellDidDeleted:self];
}

@end
