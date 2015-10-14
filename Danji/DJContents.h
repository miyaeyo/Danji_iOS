//
//  Contents.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface DJContents : NSOperation

@property (nonatomic, readonly) PFFile    *image;
@property (nonatomic, readonly) NSString  *body;
@property (nonatomic, readonly) NSString  *reference;
@property (nonatomic, readonly) NSInteger likeCount;

@end