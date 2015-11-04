//
//  AppDelegate.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Danji.h"


@implementation AppDelegate

#pragma mark - state

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse enableLocalDatastore];
    [Danji registerSubclass];
    [Parse setApplicationId:@"9bsJRraxnOoVjbhqsCjA35Gb4OMc29jzwcuZCKRq"
                  clientKey:@"A3ydVgCH2c8QKwLUEmUS36fMprzVingTwDuMVyGb"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end

