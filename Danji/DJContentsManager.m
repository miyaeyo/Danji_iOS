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
        
        PFQuery *referenceQuery = [DJContents query];
        [referenceQuery whereKey:@"reference" containsString:searchText];
        
        PFQuery *bodyQuery = [DJContents query];
        [bodyQuery whereKey:@"body" containsString:searchText];
        
        PFQuery *query = [PFQuery orQueryWithSubqueries:@[referenceQuery, bodyQuery]];
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


- (void)contentsFromParseDBWithCategory:(NSString *)category
{
    @autoreleasepool
    {
        PFQuery *query = [DJContents query];
        [query whereKey:@"category" equalTo:category];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error)
         {
             if (!error)
             {
                 [mDelegate contentsManager:self didFinishGetContentsList:objects];
             }
             else
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
         }];
    }
}


#pragma mark - increase like count

- (void)increaseLikeCountInContents:(DJContents *)contents
{
    NSUInteger likeCount = [[contents likeUsers] count];
    [contents addUniqueObject:[[PFUser currentUser] username]  forKey:@"likeUsers"];
    
    if ([[contents likeUsers] count] - likeCount == 1)
    {
        [contents incrementKey:@"likeCount"];
        [contents saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
         {
             if (succeeded)
             {
                 [mDelegate contentsManager:self didFinishIncreaseLikeCount:[contents likeCount]];
             }
             else
             {
                 NSLog(@"%@", [error description]);
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

