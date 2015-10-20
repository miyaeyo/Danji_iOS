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
    __weak id<DJPopularContentsDelegate> mDelegate;
}


@synthesize delegate = mDelegate;


- (IBAction)buttonTapped:(id)sender
{
    [mDelegate popularContentsCell:self didContentsTapped:[mTitle text]];
}


- (void)inputData:(Danji *)danji withRank:(NSInteger)rank
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIImage imageNamed:@"music"], @"music",
                                [UIImage imageNamed:@"movie"], @"movie",
                                [UIImage imageNamed:@"drama"], @"drama",
                                [UIImage imageNamed:@"cartoon"], @"cartoon",
                                [UIImage imageNamed:@"poem"], @"poem",
                                [UIImage imageNamed:@"book"], @"book", nil];
    

    [mRank setText:[NSString stringWithFormat:@"%ld", rank]];
    [mIcon setImage:[dictionary objectForKey:[danji Category]]];
    [mTitle setText:[danji Title]];
}


@end
