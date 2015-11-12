//
//  DJHomeViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContentsViewCell.h"
#import "UIColor+DanjiColor.h"

@implementation DJContentsViewCell
{
    UIImageView *mImage;
    UILabel     *mBody;
    UILabel     *mLikeCount;
    UILabel     *mReference;
    UIButton    *mLikeButton;
    
    CGFloat     mImageHeight;
    CGFloat     mBodyHeight;
    
    DJContents  *mContents;
    UIImage     *mContentsImage;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        mImageHeight = 0;
        mBodyHeight = 0;
        mContents = nil;
        mContentsImage = [[UIImage alloc] init];
        
        mImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        mBody = [[UILabel alloc] initWithFrame:CGRectZero];
        mLikeCount = [[UILabel alloc] initWithFrame:CGRectZero];
        mReference = [[UILabel alloc] initWithFrame:CGRectZero];
        mLikeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}


#pragma mark - subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupImageView];
    [self setupBodyView];
    [self setupBottomView];
}


#pragma mark - public

- (void)inputContents:(DJContents *)contents
{
    mContents = contents;
    [self convertImageFromPFFile:[contents image]];
}


#pragma mark - action

- (IBAction)likeButtonTapped:(id)sender
{
    [mContents incrementKey:@"likeCount"];
    [mContents saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
    {
        if (succeeded)
        {
            [mLikeCount setText:[NSString stringWithFormat:@"%ld", [mContents likeCount]]];
            if ([mContents likeCount] > 9999)
            {
                [self setNeedsLayout];
            }
        }
        else
        {
            NSLog(@"%@", [error description]);
        }
    }];
}


#pragma mark - setup

- (void)setupImageView
{
    [mImage setImage:mContentsImage];
    [mImage sizeToFit];
    mImageHeight = [mImage bounds].size.height;
    [self addSubview:mImage];
}

- (void)setupBodyView
{
    CGFloat screenWidth = [self bounds].size.width;
    CGFloat margin = 10.0f;
    
    [mBody setFrame:CGRectMake(margin, mImageHeight + margin, screenWidth - 2 * margin, mBodyHeight)];
    [mBody setText:[mContents body]];
    [mBody setTextColor:[UIColor blackColor]];
    [mBody setFont:[UIFont systemFontOfSize:13]];
    [mBody setNumberOfLines:0];
    [mBody setLineBreakMode:NSLineBreakByWordWrapping];
    [mBody sizeToFit];
    mBodyHeight = [mBody bounds].size.height;
    [self addSubview:mBody];
}

- (void)setupBottomView
{
    CGFloat screenWidth = [self bounds].size.width;
    CGFloat margin = 10.0f;
    CGFloat buttonSize = 28;
    CGFloat bottomY = mImageHeight + mBodyHeight + 2 * margin;
    CGFloat likeViewWidth = buttonSize + 45;

    [mLikeButton setFrame:CGRectMake(0, bottomY, buttonSize, buttonSize)];
    [mLikeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [mLikeButton setBackgroundColor:[UIColor DJPinkColor]];
    [mLikeButton addTarget:self action:@selector(likeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mLikeButton];
    
    
    if ([mContents likeCount] > 9999)
    {
        [mLikeCount sizeToFit];
        CGFloat newWidth = [mLikeCount bounds].size.width + 4;
        [mLikeCount setFrame:CGRectMake(buttonSize, bottomY, newWidth, buttonSize)];
        likeViewWidth = buttonSize + newWidth;
    }
    else
    {
        [mLikeCount setFrame:CGRectMake(buttonSize, bottomY, 45, buttonSize)];
    }
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", (long)[mContents likeCount]]];
    [mLikeCount setBackgroundColor:[UIColor DJPinkColor]];
    [mLikeCount setTextColor:[UIColor whiteColor]];
    [mLikeCount setFont:[UIFont boldSystemFontOfSize:15]];
    [mLikeCount setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:mLikeCount];
    
    [mReference setFrame:CGRectMake(likeViewWidth + margin / 2, bottomY, screenWidth - likeViewWidth - margin, buttonSize)];
    [mReference setText:[mContents reference]];
    [mReference setTextColor:[UIColor DJBrownColor]];
    [mReference setFont:[UIFont boldSystemFontOfSize:14]];
    [mReference setTextAlignment:NSTextAlignmentRight];
    [mReference setNumberOfLines:0];
    [mReference setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:mReference];
}


- (void)convertImageFromPFFile:(PFFile *)image
{
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
     {

         if (!error)
         {
             UIImage *original = [UIImage imageWithData:data];
             CGSize originalSize = CGSizeMake([mContents imageWidth], [mContents imageHeight]);
             CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
             CGSize newSize = CGSizeMake(screenWidth, originalSize.height * screenWidth / originalSize.width);
             
             UIGraphicsBeginImageContext(newSize);
             [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
             UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
             UIGraphicsEndImageContext();
             
             mContentsImage = resized;
             [self setNeedsLayout];
         }
         else
         {
              NSLog(@"%@ %@", error, [error userInfo]);
         }
         
     }];
}


@end

