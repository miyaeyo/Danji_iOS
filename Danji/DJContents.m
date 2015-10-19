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
}

@synthesize image = mImage;
@synthesize body = mBody;
@synthesize reference = mReference;
@synthesize likeCount = mLikeCount;


#pragma mark - init


+ (instancetype)contentsWithImage:(PFFile *)image
                             body:(NSString *)body
                        reference:(NSString *)reference
                        likeCount:(NSInteger)likeCount
{
    return [[self alloc] initWithImage:image body:body reference:reference likeCount:likeCount];
}

- (instancetype)initWithImage:(PFFile *)image
                         body:(NSString *)body
                    reference:(NSString *)reference
                    likeCount:(NSInteger)likeCount
{
    self = [super init];
    
    if (self)
    {
        mImage = image;
        mBody = body;
        mReference = reference;
        mLikeCount = likeCount;
    }
    
    return self;
}


@end
