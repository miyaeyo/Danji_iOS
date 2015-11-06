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
//    __weak IBOutlet UIImageView *mImage;
//    __weak IBOutlet UILabel *mBody;
//    __weak IBOutlet UILabel *mLikeCount;
//    __weak IBOutlet UILabel *mReference;
//    __weak IBOutlet UIButton *mLikeButton;
    
    UIImageView *mImage;
    UILabel     *mBody;
    UILabel     *mLikeCount;
    UILabel     *mReference;
    UIButton    *mLikeButton;
    CGFloat            mImageHeight;
    CGFloat            mBodyHeight;
    CGFloat            mReferenceHeight;
    CGFloat            mCellHeight;
    
    DJContents *mContents;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        mImageHeight = 0;
        mBodyHeight = 0;
        mReferenceHeight = 0;
        mCellHeight = 0;
        mContents = nil;
        
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
    NSLog(@"2. layoutSubviews");
    [self setupImageView];
    [self setupBodyView];
    [self setupBottomView];
    NSLog(@"3. height image: %lf, body: %lf", mImageHeight, mBodyHeight);
}


#pragma mark - public

- (void)inputContents:(DJContents *)contents
{
    mContents = contents;
    NSLog(@"%@", [contents title]);
    
    [self setupImage:[contents image]];
    [mBody setText:[contents body]];
    [mBody sizeToFit];
    mBodyHeight = [mBody bounds].size.height;
    
    
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", (long)[contents likeCount]]];
    [mReference setText:[contents reference]];
    [mReference sizeToFit];
   // NSLog(@"4. height image: %lf, body: %lf", mImageHeight, mBodyHeight);
    
    [self setNeedsLayout];
}

- (CGFloat)height
{
    if (mContents)
    {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat imageHeight = [mContents imageHeight] * screenSize.width / [mContents imageWidth];
        
        return mBodyHeight + imageHeight + mReferenceHeight;
    }
    else
    {
        return 0;
    }
   
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

- (void)setupImageView
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    [mImage setFrame:CGRectMake(0, 0, screenWidth, mImageHeight)];
    [self addSubview:mImage];
}

- (void)setupBodyView
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat margin = 10.0f;
    
    [mBody setFrame:CGRectMake(0, mImageHeight + margin, screenWidth - margin, mBodyHeight)];
    [mBody setTextColor:[UIColor blackColor]];
    [mBody setFont:[UIFont systemFontOfSize:13]];
    [mBody setNumberOfLines:0];
    [mBody setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:mBody];
}

- (void)setupBottomView
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat margin = 10.0f;
    CGFloat buttonSize = 28;
    CGFloat bottomY = mImageHeight + mBodyHeight + 2 * margin;
    
    [mLikeButton setFrame:CGRectMake(0, bottomY, buttonSize, buttonSize)];
    [mLikeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [mLikeButton setBackgroundColor:[UIColor DJPinkColor]];
    [self addSubview:mLikeButton];
    
    [mLikeCount setFrame:CGRectMake(buttonSize, bottomY, 45, buttonSize)];
    [mLikeCount setBackgroundColor:[UIColor DJPinkColor]];
    [mLikeCount setTextColor:[UIColor whiteColor]];
    [mLikeCount setFont:[UIFont boldSystemFontOfSize:15]];
    [self addSubview:mLikeCount];
    
    CGFloat likeViewWidth = buttonSize + 45;
    [mReference setFrame:CGRectMake(likeViewWidth, bottomY, screenWidth - likeViewWidth - margin , mReferenceHeight)];
    [mReference setTextColor:[UIColor DJBrownColor]];
    [mReference setFont:[UIFont boldSystemFontOfSize:14]];
    [mReference setNumberOfLines:0];
    [mReference setLineBreakMode:NSLineBreakByWordWrapping];
 
    mCellHeight = bottomY + mReferenceHeight;
    [self addSubview:mReference];
}

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
         
         mImageHeight = newSize.height;
         [mImage setImage:resized];
         [mImage sizeToFit];
         //NSLog(@"image %lf, %lf", mImageHeight, [mImage frame].size.height);
         [self setNeedsLayout];
         [self layoutIfNeeded];
     }];
    
    
}


@end

