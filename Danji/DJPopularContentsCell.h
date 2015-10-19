//
//  DJPopularContentsCell.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Danji.h"


@class DJPopularContentsCell;

@protocol DJPopularContentsDelegate <NSObject>

@required
- (void)popularContentsCell:(DJPopularContentsCell *)cell didContentsTapped:(NSString *)title;

@end


@interface DJPopularContentsCell : UITableViewCell

@property (nonatomic, weak) id<DJPopularContentsDelegate> delegate;

- (void)inputData:(Danji *)danji withRank:(NSInteger)rank;

@end
