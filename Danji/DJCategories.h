//
//  Categories.h
//  Danji
//
//  Created by miyaeyo on 2015. 11. 6..
//  Copyright © 2015년 miyaeyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DJCategories : NSObject

- (NSArray *)categories;
- (UIImage *)imageForIcon:(NSString *)name;

@end
