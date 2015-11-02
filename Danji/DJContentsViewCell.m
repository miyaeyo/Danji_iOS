//
//  DJHomeViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContentsViewCell.h"

@implementation DJContentsViewCell
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
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", (long)[contents likeCount]]];
    [mReference setText:[contents reference]];
    
}


#pragma mark - action

- (IBAction)likeButtonTapped:(id)sender
{
    NSInteger likeCount = [[mLikeCount text] integerValue];
    likeCount ++;
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", (long)likeCount]];
    //to do: db에 likecount 변동 반영
}


#pragma mark - setup

- (void)setupImage:(PFFile *)image
{
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@ %@", error, [error userInfo]);
             
             return;
         }
         
         UIImage *original = [UIImage imageWithData:data];
         CGSize screenSize = [[UIScreen mainScreen] bounds].size;
         CGSize newSize = CGSizeMake(screenSize.width, original.size.height * screenSize.width / original.size.width);
         
         UIGraphicsBeginImageContext(newSize);
         [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
         UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         
         [mImage setImage:resized];
     }];
}


@end

