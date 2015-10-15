//
//  DJContentsDelegate.h
//  Danji
//
//  Created by miyaeyo on 2015. 10. 15..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#ifndef Danji_DJContentsDelegate_h
#define Danji_DJContentsDelegate_h

#import "DJContents.h"

@protocol DJContentsDelegate <NSObject>

@required

- (void)contents:(DJContents *)contents didLikeButtonTapped;

@end

#endif
