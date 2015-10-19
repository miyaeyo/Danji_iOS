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
    
    NSArray *icons = [NSArray arrayWithObjects:[UIImage imageNamed:@"music.png"], [UIImage imageNamed:@"movie.png"], [UIImage imageNamed:@"drama.png"], [UIImage imageNamed:@"cartoon.png"], [UIImage imageNamed:@"poem.png"], [UIImage imageNamed:@"book.png"], nil];
    NSArray *categorys = [NSArray arrayWithObjects:@"music", @"movie", @"drama", @"cartoon", @"poem", @"book", nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:icons forKeys:categorys];

    [mRank setText:[NSString stringWithFormat:@"%ld", rank]];
    [mIcon setImage:[dictionary objectForKey:[danji Category]]];
    [mTitle setText:[danji Title]];
}

@end




//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//
//}
