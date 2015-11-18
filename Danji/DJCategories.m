//
//  Categories.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 6..
//  Copyright © 2015년 miyaeyo. All rights reserved.
//

#import "DJCategories.h"

@implementation DJCategories

- (NSArray *)categories
{
    return [NSArray arrayWithObjects:@"movie", @"drama", @"book", @"poem", @"music", @"cartoon", nil];
}

- (UIImage *)imageForIcon:(NSString *)name
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIImage imageNamed:@"music"], @"music",
                                [UIImage imageNamed:@"movie"], @"movie",
                                [UIImage imageNamed:@"drama"], @"drama",
                                [UIImage imageNamed:@"cartoon"], @"cartoon",
                                [UIImage imageNamed:@"poem"], @"poem",
                                [UIImage imageNamed:@"book"], @"book", nil];
    
    return [dictionary objectForKey:name];
}
@end
