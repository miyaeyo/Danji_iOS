//
//  Contents.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContents.h"

@implementation DJContents
{
    PFFile    *mImage;
    NSString  *mBody;
    NSString  *mReference;
    NSInteger mLikeCount;
    NSString  *mCategory;
    
}

@synthesize image = mImage;
@synthesize body = mBody;
@synthesize reference = mReference;
@synthesize likeCount = mLikeCount;
@synthesize category = mCategory;


#pragma mark - init


+ (instancetype)contentsWithImage:(PFFile *)image
                             body:(NSString *)body
                        reference:(NSString *)reference
                        likeCount:(NSInteger)likeCount
                         category:(NSString *)category
{
    return [[self alloc] initWithImage:image body:body reference:reference likeCount:likeCount category:category];
}

- (instancetype)initWithImage:(PFFile *)image
                         body:(NSString *)body
                    reference:(NSString *)reference
                    likeCount:(NSInteger)likeCount
                     category:(NSString *)category
{
    self = [super init];
    
    if (self)
    {
        mImage = image;
        mBody = body;
        mReference = reference;
        mLikeCount = likeCount;
        mCategory = category;
    }
    
    return self;
}


@end
