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
    __weak IBOutlet UIImageView *mContentsImage;
    __weak IBOutlet UILabel *mContentsBody;
    __weak IBOutlet UILabel *mlikeCount;
    __weak IBOutlet UILabel *mContentsReference;
    
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


