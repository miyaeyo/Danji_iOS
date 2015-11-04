//
//  DJHomeViewController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DJContentsManager.h"


@interface DJHomeViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, DJContentsDelegate, UIAlertViewDelegate>


@end
