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


- (void)contentsFromParseDB
{
    @autoreleasepool
    {
        
        PFQuery *query = [DJContents query];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [mDelegate contentsManager:self didFinishGetContentsList:results];
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
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [mDelegate contentsManager:self didFinishGetContentsList:results];
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
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [mDelegate contentsManager:self didFinishGetContentsList:results];
             
         }];
    }
}


@end

