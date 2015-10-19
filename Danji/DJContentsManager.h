//
//  DJContentsManager.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 15..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJContents.h"

@class DJContentsManager;

@protocol DJContentsDelegate <NSObject>

@required
- (void)contentsManager:(DJContentsManager *)contentsManager didFinishMakeAContents:(DJContents *)contents;

@end


@interface DJContentsManager : NSObject

@property (nonatomic, weak) id<DJContentsDelegate> delegate;

- (void)contentsFromParseDB;


@end