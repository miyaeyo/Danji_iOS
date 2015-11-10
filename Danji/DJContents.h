//
//  Contents.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <Parse/Parse.h>


@interface DJContents : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString  *userName;
@property (nonatomic, strong) NSString  *category;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *creator;
@property (nonatomic, strong) PFFile    *image;
@property (nonatomic, strong) NSString  *body;
@property (nonatomic, strong) NSString  *reference;
@property (nonatomic)         NSInteger likeCount;
@property (nonatomic, strong) NSArray   *character;
@property (nonatomic, strong) NSArray   *dialog;
@property (nonatomic)         CGFloat   imageHeight;
@property (nonatomic)         CGFloat   imageWidth;

+ (NSString *)parseClassName;

@end


