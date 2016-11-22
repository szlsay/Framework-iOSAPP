//
//  AppDelegate.m
//  Main
//
//  Created by ST on 16/11/22.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "AppDelegate.h"
#import <SonSDK/SonSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.scheme isEqualToString:@"Son"]) {
         NSLog(@"%s %@", __FUNCTION__, self);
      return [[SonSDK sharedInstance] openURL:url];
    }
    return NO;
}

@end
