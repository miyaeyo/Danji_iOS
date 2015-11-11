//
//  Categories.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 6..
//  Copyright © 2015년 miyaeyo. All rights reserved.
//

#import "DJCategories.h"

@implementation DJCategories

- (NSArray *)categoriesForMain
{
   return [NSArray arrayWithObjects:@"TOTAL", @"MOVIE", @"DRAMA", @"BOOK", @"POEM", @"MUSIC", @"CARTOON", nil];
    
}

- (NSArray *)categoriesForWrite
{
    return [NSArray arrayWithObjects:@"movie", @"drama", @"book", @"poem", @"music", @"cartoon", nil];
}
@end
