//
//  DJInputForms.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 10..
//  Copyright © 2015년 miyaeyo. All rights reserved.
//

#import "DJInputForms.h"

@implementation DJInputForms
{
    NSArray *mInputForms;
}


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        mInputForms = [[NSArray alloc] initWithObjects:@"dialog", @"paragraph", nil];
    }
    
    return self;
}


- (NSUInteger)count
{
    return [mInputForms count];
}

- (NSString *)inputFormAtIndex:(NSUInteger)index
{
    return [mInputForms objectAtIndex:index];
}


@end
