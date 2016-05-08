//
//  AppDelegate.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/16/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "AppDelegate.h"
#import "BMPostListViewController.h"
#import "UIColor+BMColor.h"
#import "BMLoginViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "Flurry.h"
#import "BMTrackUtil.h"
#import "BMAccountManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [BMTrackUtil startSession];

    // TODO: Move this to where you establish a user session
    //    [self logUser];
    // Override point for customization after application launch.
    BMPostListViewController *vc = [[BMPostListViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    navigationController.navigationBar.barTintColor = [UIColor BMNavBackgroundColor];
    [self setupRequestRegisterNotificationWithApplication:application];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [BMAccountManager sharedInstance];
    return YES;
}

//- (void) logUser {
//    // TODO: Use the current user's information
//    // You can call any combination of these three methods
//    [CrashlyticsKit setUserIdentifier:@"12345"];
//    [CrashlyticsKit setUserEmail:@"user@fabric.io"];
//    [CrashlyticsKit setUserName:@"Test User"];
//}
//

- (void)setupRequestRegisterNotificationWithApplication:(UIApplication *)application
{
    [application registerForRemoteNotifications];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                         | UIUserNotificationTypeBadge
                                                                                         | UIUserNotificationTypeSound) categories:nil];
    [application registerUserNotificationSettings:settings];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

    NSString * tempToken = [deviceToken description];
    NSString *token = @"";

    token = [tempToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [[token componentsSeparatedByString:@" "] componentsJoinedByString:@"" ];
    NSLog(@"got string token %@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error
{
    NSLog(@"error:%@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
