//
//  DJHomeViewCell.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJContents.h"
#import "DJContentsManager.h"

@interface DJContentsViewCell : UITableViewCell <DJContentsDelegate>

- (void)inputContents:(DJContents *)contents;

@end
