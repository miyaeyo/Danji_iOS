//
//  DJHomeViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJHomeViewCell.h"

@implementation DJHomeViewCell
{
    __weak IBOutlet UIImageView *mImage;
    __weak IBOutlet UILabel *mBody;
    __weak IBOutlet UILabel *mLikeCount;
    __weak IBOutlet UILabel *mReference;
    
    __weak IBOutlet UIButton *mLikeButton;
}


#pragma mark - subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
}


#pragma mark - public

- (void)inputContents:(DJContents *)contents
{
    [self setupImage:[contents image]];
    [mBody setText:[contents body]];
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", [contents likeCount]]];
    [mReference setText:[contents reference]];
    
}


#pragma mark - action

- (IBAction)likeButtonTapped:(id)sender
{
    NSInteger likeCount = [[mLikeCount text] integerValue];
    likeCount ++;
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", likeCount]];
}


#pragma mark - setup

- (void)setupImage:(PFFile *)image
{
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
    {
        if (error)
        {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
        else
        {
            UIImage *original = [UIImage imageWithData:data];
            CGSize screenSize = [[UIScreen mainScreen] bounds].size;
            CGSize newSize = CGSizeMake(screenSize.width, original.size.height * screenSize.width / original.size.width);
            
            UIGraphicsBeginImageContext(newSize);
            [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            [mImage setImage:resized];
        }
    }];
}

@end

