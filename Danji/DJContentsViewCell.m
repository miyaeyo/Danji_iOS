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
    
//    UIImageView *mImage;
//    CGSize mImageSize;
//    UILabel *mBody;
//    UILabel *mLikeCount;
//    UILabel *mReference;
//    UIButton *mLikeButton;
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    if (self)
//    {
//        mImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//        mBody = [[UILabel alloc] initWithFrame:CGRectZero];
//        mLikeCount = [[UILabel alloc] initWithFrame:CGRectZero];
//        mReference = [[UILabel alloc] initWithFrame:CGRectZero];
//        mLikeButton = [[UIButton alloc] initWithFrame:CGRectZero];
//        
//    }
//    
//    return self;
//}


#pragma mark - subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self setupImageView:mImageSize];
//    [self setupBodyLabel];
//    [self setupLikeButton];
//    [self setupLikeCountLabel];
//    [self setupReferenceLabel];
    
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
             
             return;
         }
         
         UIImage *original = [UIImage imageWithData:data];
         CGSize screenSize = [[UIScreen mainScreen] bounds].size;
         CGSize newSize = CGSizeMake(screenSize.width, original.size.height * screenSize.width / original.size.width);
         //mImageSize = newSize;
         
         UIGraphicsBeginImageContext(newSize);
         [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
         UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         
         [mImage setImage:resized];
         
     }];
}


//- (void)setupImageView:(CGSize)imageSize
//{
//    [mImage setFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
//    [mImage sizeToFit];
//    [self addSubview:mImage];
//}
//
//- (void)setupBodyLabel
//{
//    [mBody setFrame:CGRectMake(1, [mImage bounds].size.height + 1, [[UIScreen mainScreen] bounds].size.width - 2, 0)];
//    [mBody setLineBreakMode:NSLineBreakByWordWrapping];
//    [mBody setNumberOfLines:0];
//    [mBody setTextAlignment:NSTextAlignmentLeft];
//    [mBody setFont:[UIFont systemFontOfSize:13]];
//    [mBody sizeToFit];
//    [self addSubview:mBody];
//}
//
//- (void)setupLikeButton
//{
//    [mLikeButton setFrame:CGRectMake(1, [mImage bounds].size.height + [mBody bounds].size.height + 2, 30, 30)];
//    [mLikeButton setImage:[UIImage imageNamed:@"like.png"] forState:0];
//    [mLikeButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.69 blue:0.66 alpha:1]];
//    [mLikeButton addTarget:self action:@selector(likeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:mLikeButton];
//}
//
//- (void)setupLikeCountLabel
//{
//    [mLikeCount setFrame:CGRectMake(31, [mImage bounds].size.height + [mBody bounds].size.height + 2, 45, 30)];
//    [mLikeCount setBackgroundColor:[UIColor colorWithRed:0.9 green:0.69 blue:0.66 alpha:1]];
//    [mLikeCount setTintColor:[UIColor whiteColor]];
//    [mLikeCount setTextAlignment:NSTextAlignmentCenter];
//    [self addSubview:mLikeCount];
//}
//
//- (void)setupReferenceLabel
//{
//    [mReference setFrame:CGRectMake(77, [mImage bounds].size.height + [mBody bounds].size.height + 2, [[UIScreen mainScreen]bounds].size.width - 78 , 0)];
//    [mReference setLineBreakMode:NSLineBreakByWordWrapping];
//    [mReference setNumberOfLines:0];
//    [mReference setTextAlignment:NSTextAlignmentRight];
//    [mReference setTextColor:[UIColor colorWithRed:0.49 green:0.36 blue:0.34 alpha:1]];
//    [mReference setFont:[UIFont systemFontOfSize:14]];
//    
//    [self addSubview:mReference];
//}


@end

