//
//  DJSearchingViewController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 20..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJContentsManager.h"
#import "DJContents.h"


@interface DJSearchResultsController : UITableViewController <UISearchBarDelegate, DJContentsDelegate>

@property (nonatomic) BOOL searchBarEditting;

@end
