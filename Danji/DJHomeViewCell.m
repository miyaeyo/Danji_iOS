//
//  DJHomeViewCell.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJHomeViewCell.h"

@implementation DJHomeViewCell
{
    __weak IBOutlet UIImageView *mImage;
    __weak IBOutlet UILabel *mBody;
    __weak IBOutlet UILabel *mLikeCount;
    __weak IBOutlet UILabel *mReference;
    
    __weak IBOutlet UIButton *mLikeButton;
}


#pragma mark - subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - public

- (void)inputContents:(DJContents *)contents
{
    [mImage setImage:[contents image]];
    [mBody setText:[contents body]];
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", [contents likeCount]]];
    [mReference setText:[contents reference]];
    
}


#pragma mark - action

- (IBAction)likeButtonTapped:(id)sender
{
    NSInteger likeCount = [[mLikeCount text] integerValue];
    likeCount ++;
    [mLikeCount setText:[NSString stringWithFormat:@"%ld", likeCount]];
}

@end



//- (void)awakeFromNib {
//    // Initialization code
//}
//

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//


