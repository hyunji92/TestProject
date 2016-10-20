//
//  AppDelegate.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "AppDelegate.h"
#import "Tab1ViewController.h"
#import "Tab2ViewController.h"
#import "Tab3ViewController.h"
#import "Tab4ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize tabBarController;

#pragma mark ================  Applifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"application:   >>> 앱 시작점");
    self.window =  [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

     Tab1ViewController *tab1viewController = [[Tab1ViewController alloc] initWithTag:0];
     self.window.rootViewController = tab1viewController;
    // tabBarController 생성 전에 rootViewController
    
    // ViewController를 4개로 하여 만든다 .
    //Tab2ViewController *tab2viewController = [[Tab2ViewController alloc]  initWithTag:1];
    //tab2viewController.view.backgroundColor = [UIColor grayColor];
    
    
    
    /*self.tabBarController =  [[UITabBarController alloc] init];
    for (int i =0; i <4; i++) {
        Tab1ViewController *tab1viewController = [[Tab1ViewController alloc] initWithTag:i];
    
        UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:tab1viewController];
        navigationViewController.tabBarItem =  [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", i] image:nil tag:i];
        [self.tabBarController addChildViewController:navigationViewController];
    

    }
    self.window.rootViewController = tabBarController;*/
    
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor redColor];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive:   >>> 앱이 비활성화 될 때 (will 시작 직전) 1");
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground:   >>> 포그라운드에서 백그라운드로 갈 때 (did 시작이 끝난 직후)2");
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground:   >>> 백그라운드에서 포그라운드로 올 때 3");
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive:   >>> 앱 활성화 될 때 4");
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate:   >>> 앱이 종료 될 때 ");
}


@end
