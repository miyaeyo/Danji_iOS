//
//  Categories.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 6..
//  Copyright © 2015년 miyaeyo. All rights reserved.
//

#import "DJCategories.h"

@implementation DJCategories
{
    NSArray *mCategories;
}


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        mCategories = [[NSArray alloc] initWithObjects:@"TOTAL", @"MOVIE", @"DRAMA", @"BOOK", @"POEM", @"MUSIC", @"CARTOON", nil];
    }
    
    return self;
}


- (NSUInteger)count
{
    return [mCategories count];
}

- (NSString *)categoryAtIndex:(NSUInteger)index
{
    return [mCategories objectAtIndex:index];
}



@end
