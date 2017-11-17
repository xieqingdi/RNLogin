/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  NSURL *jsCodeLocation;
//
//  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
//
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                      moduleName:@"rnlogin"
//                                               initialProperties:nil
//                                                   launchOptions:launchOptions];
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//
//  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//  UIViewController *rootViewController = [UIViewController new];
//  rootViewController.view = rootView;
//  self.window.rootViewController = rootViewController;
//  [self.window makeKeyAndVisible];
  
  // 监听网络状态改变的通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
  // 创建Reachability
  self.conn = [Reachability reachabilityForInternetConnection];
  [self.conn startNotifier];
  
  return YES;
}
- (void)networkStateChange
{
  // 1.检测wifi状态
  Reachability *wifi = [Reachability reachabilityForLocalWiFi];
  
  // 2.检测手机是否能上网络(WIFI\3G\2.5G)
  Reachability *conn = [Reachability reachabilityForInternetConnection];
  
  // 3.判断网络状态
  if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
    NSLog(@"有wifi");
  } else if ([conn currentReachabilityStatus] != NotReachable) {
    // 没有使用wifi, 使用手机自带网络进行上网
    NSLog(@"使用手机自带网络进行上网");
  } else { // 没有网络
    NSLog(@"没有网络");
  }
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
