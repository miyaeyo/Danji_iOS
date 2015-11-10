//
//  DJParagraphWriteController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 22..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJParagraphWriteController.h"


@implementation DJParagraphWriteController
{
    //__weak UIViewController<DJParagraphDelegate> *mDelegate;
    __weak IBOutlet UITextView                   *mParagraph;
    NSString                                     *mEditingText;
}

//@synthesize paragraphDelegate = mDelegate;
@synthesize editingText = mEditingText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [mParagraph setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        //mDelegate = nil;
        mParagraph = nil;
        mEditingText = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![mEditingText isEqualToString:@""])
    {
        [mParagraph setText:mEditingText];
    }
    [mParagraph becomeFirstResponder];
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    //[mDelegate paragraphWriteController:self didFinishWriteParagraph:[mParagraph text]];
    //[[self navigationController] popToViewController:mDelegate animated:YES];
}


@end
