//
//  DJLoginViewController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 6..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJLoginViewController.h"

@implementation DJLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.68 green:0.8 blue:0.78 alpha:1]];
    
    UILabel *idLabel = [[UILabel alloc] initWithFrame:[[self view] bounds]];
    [idLabel setText:@"USER NAME"];
    [idLabel setTextColor:[UIColor colorWithRed:0.49 green:0.36 blue:0.35 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
