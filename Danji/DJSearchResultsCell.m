//
//  DJSearchingViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 20..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchResultsCell.h"

@implementation DJSearchResultsCell
{
    __weak IBOutlet UIImageView *mCategory;
    __weak IBOutlet UILabel *mTitle;
    __weak IBOutlet UILabel *mBody;
}


- (void)inputTitle:(NSString *)title body:(NSString *)body category:(NSString *)category
{
    [mTitle setText:title];
    [mBody setText:body];
    [mCategory setImage:[self imageForCategory:category]];
}


- (UIImage *)imageForCategory:(NSString *)category
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIImage imageNamed:@"music"], @"music",
                                [UIImage imageNamed:@"movie"], @"movie",
                                [UIImage imageNamed:@"drama"], @"drama",
                                [UIImage imageNamed:@"cartoon"], @"cartoon",
                                [UIImage imageNamed:@"poem"], @"poem",
                                [UIImage imageNamed:@"book"], @"book", nil];
    
    return [dictionary objectForKey:category];
}

@end
