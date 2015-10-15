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
#import "DJContents.h"

@implementation DJContentsManager

- (NSArray *)contentsList
{
    @autoreleasepool {
        NSMutableArray *tempContentsList = [[NSMutableArray alloc] init];
        
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
                     @autoreleasepool {
                         [[aDanji ContentsImage] getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
                         {
                             if (error)
                             {
                                 NSLog(@"%@ %@", error, [error userInfo]);
                             }
                             else
                             {
                                 UIImage *image = [UIImage imageWithData:data];
                                 
                                 //UIImage *image = [self imageFromPFFile:[aDanji ContentsImage]];
                                 NSString *body = [aDanji ContentsBody];
                                 NSString *reference = [[[aDanji Creator] stringByAppendingString:@", "] stringByAppendingString:[aDanji Title]];
                                 NSInteger likeCount = [aDanji LikeCount];
                                 
                                 DJContents *contents = [DJContents contentsWithImage:image body:body reference:reference likeCount:likeCount];
                                 [tempContentsList addObject:contents];

                             }
                         }];

                     }
                }
             }
         }];
        
        return [NSArray arrayWithArray:tempContentsList];
    }
   
}

//- (UIImage *)imageFromPFFile:(PFFile *)file
//{
//    // 이 작업을 thread로 빼서할건지 생각해보기...
//
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
//    {
//        if (error)
//        {
//            NSLog(@"%@ %@", error, [error userInfo]);
//        }
//        else
//        {
//           image = [UIImage imageWithData:data];
//        }
//    }];
//    
//    
//    //return [UIImage imageWithData:[file getData]];
//}

@end
