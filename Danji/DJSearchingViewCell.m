//
//  DJSearchingViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 20..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJSearchingViewCell.h"

@implementation DJSearchingViewCell
{
    __weak IBOutlet UILabel *mTitle;
    __weak IBOutlet UILabel *mBody;
}


- (void)inputTitle:(NSString *)title body:(NSString *)body
{
    [mTitle setText:title];
    [mBody setText:body];
}

- (IBAction)searchResultTapped:(id)sender
{
}


@end
