//
//  ParseObjectDanji.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "Danji.h"
#import <Parse/PFObject+Subclass.h>

@implementation Danji

@dynamic UserName;
@dynamic Category;
@dynamic Title;
@dynamic Creator;
@dynamic ContentsImage;
@dynamic ContentsBody;
@dynamic LikeCount;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Danji";
}

@end


/*
 @dynamic userName;
 @dynamic category;
 @dynamic title;
 @dynamic creator;
 @dynamic image;
 @dynamic body;
 @dynamic likeCount;
 */

