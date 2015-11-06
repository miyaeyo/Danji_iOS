//
//  Contents.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContents.h"

@implementation DJContents

@dynamic userName;
@dynamic category;
@dynamic title;
@dynamic creator;
@dynamic image;
@dynamic body;
@dynamic reference;
@dynamic likeCount;
@dynamic character;
@dynamic dialog;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"DJContents";
}

@end



