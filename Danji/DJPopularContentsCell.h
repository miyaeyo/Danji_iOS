//
//  DJPopularContentsCell.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 19..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJContents.h"


@interface DJPopularContentsCell : UITableViewCell

- (void)inputData:(DJContents *)contents withRank:(NSInteger)rank;

@end
