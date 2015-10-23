//
//  DJDialogWriteController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DJDialogWriteController;

@protocol DJDialogWriteDelegate <NSObject>

@required
- (void)dialogeWriteController:(DJDialogWriteController *)controller didFinishWriteCharacter:(NSArray *)caracters dialog:(NSArray *)dialogs;

@end


@interface DJDialogWriteController : UITableViewController

@property (nonatomic, weak) UIViewController<DJDialogWriteDelegate> *dialogDelegate;

@end
