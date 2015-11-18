//
//  DJPopularContentsCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJPopularContentsCell.h"
#import "DJCategories.h"

@implementation DJPopularContentsCell
{
    __weak IBOutlet UILabel *mRank;
    __weak IBOutlet UIImageView *mIcon;
    __weak IBOutlet UILabel *mTitle;
}


- (void)inputData:(DJContents *)contents withRank:(NSInteger)rank
{
    DJCategories *categories = [[DJCategories alloc] init];
    [mRank setText:[NSString stringWithFormat:@"%ld", (long)rank]];
    [mIcon setImage:[categories imageForIcon:[contents category]]];
    [mTitle setText:[contents title]];
}

@end
