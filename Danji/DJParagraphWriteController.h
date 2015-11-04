//
//  DJParagraphWriteController.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DJParagraphWriteController;

@protocol DJParagraphDelegate <NSObject>

@required
- (void)paragraphWriteController:(DJParagraphWriteController *)controller didFinishWriteParagraph:(NSString *)paragraph;

@end


@interface DJParagraphWriteController : UIViewController

@property (nonatomic, weak) UIViewController<DJParagraphDelegate> *paragraphDelegate;
@property (nonatomic, strong) NSString *editingText;

@end
