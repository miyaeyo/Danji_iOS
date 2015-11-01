//
//  DJImagePicker.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 2..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJImagePickerController.h"


@implementation DJImagePickerController
{
    __weak id<DJImagePickerControllerDelegate> mDelegate;
    NSInteger mMaxSelectionCount;
}

@synthesize delegate = mDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mMaxSelectionCount = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - asset selection delegate

- (void)selectedAssets:(NSArray *)assets
{
    NSMutableArray *returnImages = [[NSMutableArray alloc] init];
    
}

- (BOOL)shouldSelectAsset:(DJAsset *)asset previousCount:(NSUInteger)previousCount
{
    BOOL shouldSelect = previousCount < mMaxSelectionCount;
    
    if (!shouldSelect)
    {
        [[[UIAlertView alloc] initWithTitle:@"Over maximun selection count"
                                    message:[NSString stringWithFormat:@"You can select %ld photos", mMaxSelectionCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    
    return shouldSelect;
}

- (BOOL)shouldDeselectAsset:(DJAsset *)asset previousCount:(NSUInteger)previousCount
{
    return YES;
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
