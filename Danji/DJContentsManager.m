//
//  DJContentsManager.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 15..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJContentsManager.h"
#import <Parse/Parse.h>
#import "Danji.h"


@implementation DJContentsManager
{
    __weak id<DJContentsDelegate> mDelegate;
}

@synthesize delegate = mDelegate;


- (void)contentsFromParseDB
{
    @autoreleasepool
    {
        
        PFQuery *query = [Danji query];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [self setupContentsWithContentsList:results];
        }];
    }
}


- (void)contentsFromParseDBWithTitleQuery:(NSString *)aQuery
{
    @autoreleasepool
    {
        
        PFQuery *query = [Danji query];
        [query whereKey:@"Title" containsString:aQuery];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [self setupContentsWithContentsList:results];
             
         }];
    }
}


- (void)contentsFromParseDBWithBodyQuery:(NSString *)aQuery
{
    @autoreleasepool
    {
        PFQuery *query = [Danji query];
        [query whereKey:@"ContentsBody" containsString:aQuery];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             
             [self setupContentsWithContentsList:results];
         }];
    }
}

- (void)contentsFromParseDBWithLikeCount:(NSInteger)count
{
    @autoreleasepool
    {
        PFQuery *query = [Danji query];
        [query orderByDescending:@"LikeCount"];
        [query setLimit:count];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                 return;
             }
             [self setupContentsWithContentsList:results];             
        }];

    }
    
}


- (void)setupContentsWithContentsList:(NSArray *)aContentsList
{
    //Danji랑 DJContents 합치기
    for (Danji *danji in aContentsList)
    {
        @autoreleasepool
        {
            PFFile *image = [danji ContentsImage];
            NSString *body = [danji ContentsBody];
            NSString *reference;
            
            if ([[danji Creator] isEqualToString:@""])
            {
                reference = [NSString stringWithString:[danji Title]];
            }
            else
            {
                reference = [NSString stringWithFormat:@"%@ - %@", [danji Title], [danji Creator]];
            }
            
            NSInteger likeCount = [danji LikeCount];
            NSString *category = [danji Category];
            DJContents *contents = [DJContents contentsWithImage:image
                                                            body:body
                                                       reference:reference
                                                       likeCount:likeCount
                                                        category:category];
            
            [mDelegate contentsManager:self didFinishMakeAContents:contents];
        }
    }

}

@end
