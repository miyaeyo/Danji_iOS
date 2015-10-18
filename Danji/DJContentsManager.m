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
    @autoreleasepool {
        
        PFQuery *query = [Danji query];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
             else
             {
                 for (Danji *aDanji in results)
                 {
                     @autoreleasepool
                     {
                         PFFile *image = [aDanji ContentsImage];
                         NSString *body = [aDanji ContentsBody];
                         NSString *reference;
                         
                         if ([[aDanji Creator] isEqualToString:@""])
                         {
                             reference = [NSString stringWithString:[aDanji Title]];
                         }
                         else
                         {
                              reference = [NSString stringWithFormat:@"%@, %@", [aDanji Creator], [aDanji Title]];
                         }
                        
                         NSInteger likeCount = [aDanji LikeCount];
                         DJContents *contents = [DJContents contentsWithImage:image body:body reference:reference likeCount:likeCount];
                         
                         [mDelegate contentsManager:self didFinishMakeAContents:contents];
                         
                     }
                }
             }
         }];
        
    }
   
}


@end
