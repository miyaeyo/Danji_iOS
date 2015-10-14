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

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Danji";
}

@end
