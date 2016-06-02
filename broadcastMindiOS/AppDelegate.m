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
#import "testViewController.h"
#import "BMTabBarController.h"
#import "UIImage+BMImage.h"
@interface AppDelegate ()
@property (strong, nonatomic) BMTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [BMTrackUtil startSession];

    // TODO: Move this to where you establish a user session
    //    [self logUser];
    // Override point for customization after application launch.
    [self launchMainFlow];
    [self setupRequestRegisterNotificationWithApplication:application];
    //    testViewController *testVc = [[testViewController alloc] init];

    [BMAccountManager sharedInstance];
    return YES;
}

- (void)launchMainFlow
{

    // Shifting tab bar item image's position.
    UIEdgeInsets tabBarImageEdgeInsets //= UIEdgeInsetsMake(9.0f, 10.0f, 9.0f, 10.0f);
    = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);

    // Generating main window for Auction project.
    UIScreen *screen = [UIScreen mainScreen];
    self.window = [[UIWindow alloc] initWithFrame:screen.bounds];
    self.window.screen = screen;

    // Implement UITabBarController.
    self.tabBarController = [[BMTabBarController alloc] init];

    BMPostListViewController *bmPostListViewController = [[BMPostListViewController alloc] init];

    bmPostListViewController.tabBarItem.image = [UIImage image:[UIImage imageNamed:@"Icon-Feeds"] newsize:CGSizeMake(20.0f, 17.0f)];
    bmPostListViewController.tabBarItem.imageInsets = tabBarImageEdgeInsets;
    bmPostListViewController.tabBarItem.title = @"Feeds";

    UINavigationController *navBMPostListViewController = [[UINavigationController alloc] initWithRootViewController:bmPostListViewController];
    navBMPostListViewController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.tabBarController addChildViewController:navBMPostListViewController];

    testViewController *test = [[testViewController alloc] init];
    test.tabBarItem.image
    = [UIImage image:[UIImage imageNamed:@"Icon-Setting"] newsize:CGSizeMake(20.0f, 20.0f)];

    test.tabBarItem.imageInsets = tabBarImageEdgeInsets;
    test.tabBarItem.title = @"Setting";
    [self.tabBarController addChildViewController:test];

    testViewController *test2 = [[testViewController alloc] init];
    test2.tabBarItem.image = [UIImage image:[UIImage imageNamed:@"Icon-Setting"] newsize:CGSizeMake(20.0f, 20.0f)];

    test2.tabBarItem.imageInsets = tabBarImageEdgeInsets;
    test2.tabBarItem.title = @"Setting";
    
    [self.tabBarController addChildViewController:test2];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];



    //for tabbar background color
    CGSize barBackgroundSize = self.tabBarController.tabBar.frame.size;
    barBackgroundSize = CGSizeMake(barBackgroundSize.width/self.tabBarController.childViewControllers.count, barBackgroundSize.height);
    UIGraphicsBeginImageContextWithOptions(barBackgroundSize, false, 0);
    [[UIColor BMTabbarSelectedColor] setFill];
    UIRectFill(CGRectMake(0, 0, barBackgroundSize.width, barBackgroundSize.height));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   [[UITabBar appearance] setSelectionIndicatorImage:backgroundImage];
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize andOffSet:(CGPoint)offSet{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(offSet.x, offSet.y, newSize.width-offSet.x, newSize.height-offSet.y)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
