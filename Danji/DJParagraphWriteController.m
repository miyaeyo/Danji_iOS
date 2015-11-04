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
    __weak UIViewController<DJParagraphDelegate> *mDelegate;
    __weak IBOutlet UITextView                   *mParagraph;
    NSString                                     *mEditingText;
}

@synthesize paragraphDelegate = mDelegate;
@synthesize editingText = mEditingText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![mEditingText isEqualToString:@""])
    {
        [mParagraph setText:mEditingText];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action

- (IBAction)doneButtonTapped:(id)sender
{
    [mDelegate paragraphWriteController:self didFinishWriteParagraph:[mParagraph text]];
    [[self navigationController] popToViewController:mDelegate animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
