//
//  DJPopularContentsCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJPopularContentsCell.h"

@implementation DJPopularContentsCell
{
    __weak IBOutlet UILabel *mRank;
    __weak IBOutlet UIImageView *mIcon;
    __weak IBOutlet UILabel *mTitle;
}


- (void)inputData:(DJContents *)contents withRank:(NSInteger)rank
{
    [mRank setText:[NSString stringWithFormat:@"%ld", (long)rank]];
    [mIcon setImage:[self imageForIcon:[contents category]]];
    NSString *title = [[[contents reference] componentsSeparatedByString:@" - "] objectAtIndex:0];
    [mTitle setText:title];
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
