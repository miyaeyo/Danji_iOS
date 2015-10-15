//
//  ParseObjectDanji.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 14..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <Parse/Parse.h>


@interface Danji : PFObject <PFSubclassing>


@property (nonatomic, strong) NSString  *UserName;
@property (nonatomic, strong) NSString  *Category;
@property (nonatomic, strong) NSString  *Title;
@property (nonatomic, strong) NSString  *Creator;
@property (nonatomic, strong) PFFile    *ContentsImage;
@property (nonatomic, strong) NSString  *ContentsBody;
@property (nonatomic) NSInteger         LikeCount;


+ (NSString *)parseClassName;


@end


/* 새로 만들 db DANJI class의 key값
 @property (nonatomic, strong) NSString  *userName;
 @property (nonatomic, strong) NSString  *category;
 @property (nonatomic, strong) NSString  *title;
 @property (nonatomic, strong) NSString  *creator;
 @property (nonatomic, strong) PFFile    *image;
 @property (nonatomic, strong) NSString  *body;
 @property (nonatomic) NSInteger         likeCount;
 */
