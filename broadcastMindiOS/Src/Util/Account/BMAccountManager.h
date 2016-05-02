//
//  BMAccountManager.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMCacheData.h"
#import "BMUser.h"
#import "BMService.h"

static NSString * const BMAccountManagerUserLoginSuccessNotification = @"BMAccountManagerUserLoginSuccessNotification";
static NSString * const BMAccountManagerUserLogoutSuccessNotification = @"BMAccountManagerUserLogoutSuccessNotification";
static NSString * const BMAccountManagerUserLoginFailNotification = @"BMAccountManagerUserLoginFailNotification";
static NSString * const BMAccountManagerUserLogoutFailNotification = @"BMAccountManagerUserLogoutFailNotification";

@interface BMAccountManager : NSObject

+ (instancetype)sharedInstance;
- (void)requestLoginWithParentViewController:(UIViewController *)parentViewController;
- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)logout;
- (BMUser *)currentUser;

//- (BMCacheData *)convertShareCookiesToCacheData;
//- (void)saveCookieToCache;
//- (void)loadCookie;
@end