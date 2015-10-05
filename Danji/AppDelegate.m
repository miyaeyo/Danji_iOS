//
//  AppDelegate.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 4..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "AppDelegate.h"
#import "DJHomeViewController.h"
#import "DJSearchViewController.h"
#import "DJWriteViewController.h"
#import "DJMypageViewController.h"


@implementation AppDelegate


#pragma mark - state


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
    [self setWindow:window];
    
    [self setupTabBarControllerWithViewCortollers:[self setupViewControllers]];
    

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


#pragma mark - setup


- (void)setupTabBarControllerWithViewCortollers:(NSArray *)viewControllers
{
    UITabBarController *tabbarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    [tabbarController setViewControllers:viewControllers];
    [[tabbarController tabBar] setBarTintColor:[UIColor colorWithRed:0.49 green:0.36 blue:0.35 alpha:1]];
    
    [[tabbarController tabBar] setTintColor:[UIColor whiteColor]];
    
    UITabBarItem *home = [[[tabbarController tabBar] items] objectAtIndex:0];
    UITabBarItem *search = [[[tabbarController tabBar] items] objectAtIndex:1];
    UITabBarItem *write = [[[tabbarController tabBar] items] objectAtIndex:2];
    UITabBarItem *mypage = [[[tabbarController tabBar] items] objectAtIndex:3];
    
    [home setImage:[UIImage imageNamed:@"home.png"]];
    [home setTitle:@"home"];
    [search setImage:[UIImage imageNamed:@"search.png"]];
    [search setTitle:@"search"];
    [write setImage:[UIImage imageNamed:@"write.png"]];
    [write setTitle:@"write"];
    [mypage setImage:[UIImage imageNamed:@"mypage.png"]];
    [mypage setTitle:@"mypage"];
    
    [[self window] setRootViewController:tabbarController];
}


- (NSArray *)setupViewControllers
{
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    [viewControllers addObject:[self setupHomeViewController]];
    [viewControllers addObject:[self setupSearchViewController]];
    [viewControllers addObject:[self setupWriteViewController]];
    [viewControllers addObject:[self setupMypageViewController]];
    
    return [NSArray arrayWithArray:viewControllers];
}


- (UINavigationController *)setupHomeViewController
{
    DJHomeViewController *viewController = [[DJHomeViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
    
    UINavigationController *navigationViewController = [[UINavigationController alloc]
                                                        initWithRootViewController:viewController];
    
    [[navigationViewController navigationBar] setBarTintColor:[UIColor colorWithRed:0.68
                                                                              green:0.8
                                                                               blue:0.78 alpha:1]];
    return navigationViewController;
}


- (UINavigationController *)setupSearchViewController
{
    DJSearchViewController *viewController = [[DJSearchViewController alloc] initWithNibName:nil
                                                                                      bundle:nil];
    
    UINavigationController *navigationViewController = [[UINavigationController alloc]
                                                        initWithRootViewController:viewController];
    
    [[navigationViewController navigationBar] setBarTintColor:[UIColor colorWithRed:0.68
                                                                              green:0.8
                                                                               blue:0.78 alpha:1]];
    return navigationViewController;
}


- (UINavigationController *)setupWriteViewController
{
    DJWriteViewController *viewController = [[DJWriteViewController alloc] initWithNibName:nil
                                                                                    bundle:nil];
    
    UINavigationController *navigationViewController = [[UINavigationController alloc]
                                                        initWithRootViewController:viewController];
    
    [[navigationViewController navigationBar] setBarTintColor:[UIColor colorWithRed:0.68
                                                                              green:0.8
                                                                               blue:0.78 alpha:1]];
    return navigationViewController;
}


- (UINavigationController *)setupMypageViewController
{
    DJMypageViewController *viewController = [[DJMypageViewController alloc] initWithNibName:nil
                                                                                      bundle:nil];
    
    UINavigationController *navigationViewController = [[UINavigationController alloc]
                                                        initWithRootViewController:viewController];
    
    [[navigationViewController navigationBar] setBarTintColor:[UIColor colorWithRed:0.68
                                                                              green:0.8
                                                                               blue:0.78 alpha:1]];
    return navigationViewController;
}


@end
