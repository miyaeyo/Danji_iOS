//
//  DJContentsManager.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 15..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContentsManager.h"
#import <Parse/Parse.h>


@implementation DJContentsManager
{
    __weak id<DJContentsDelegate> mDelegate;
}

@synthesize delegate = mDelegate;


#pragma mark - contents from parse db

- (void)contentsFromParseDB
{
    @autoreleasepool
    {
        
        PFQuery *query = [DJContents query];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (!error)
             {
                 [mDelegate contentsManager:self didFinishGetContentsList:results];
             }
             else
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
        }];
    }
}



- (void)contentsFromParseDBWithLikeCount:(NSInteger)count
{
    @autoreleasepool
    {
        PFQuery *query = [DJContents query];
        [query orderByDescending:@"likeCount"];
        [query setLimit:count];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (!error)
             {
                 [mDelegate contentsManager:self didFinishGetContentsList:results];
             }
             else
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
        }];

    }
    
}


- (void)contentsFromParseDBWithSearchText:(NSString *)searchText
{
    @autoreleasepool
    {
        
        PFQuery *titleQuery = [DJContents query];
        [titleQuery whereKey:@"title" containsString:searchText];
        
        PFQuery *bodyQuery = [DJContents query];
        [bodyQuery whereKey:@"body" containsString:searchText];
        
        PFQuery *query = [PFQuery orQueryWithSubqueries:@[titleQuery, bodyQuery]];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (!error)
             {
                 [mDelegate contentsManager:self didFinishGetContentsList:results];
             }
             else
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
         }];
    }
}


#pragma mark - save

- (void)saveContentsToParseDB:(DJContents *)contents
{
    [contents saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
    {
        if (succeeded)
        {
            NSLog(@"save succeeded");
        }
        else
        {
            NSLog(@"Error: %@", [error description]);
        }
        
    }];
    
}


@end

