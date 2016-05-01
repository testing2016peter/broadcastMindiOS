//
//  BMAccountManager.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMCacheData.h"
#import "BMUser.h"
static NSString * const BMAccountManagerUserLoginSuccessNotification = @"BMAccountManagerUserLoginSuccessNotification";
static NSString * const BMAccountManagerUserLogoutSuccessNotification = @"BMAccountManagerUserLogoutSuccessNotification";
static NSString * const BMAccountManagerUserLoginFailNotification = @"BMAccountManagerUserLoginFailNotification";
static NSString * const BMAccountManagerUserLogoutFailNotification = @"BMAccountManagerUserLogoutFailNotification";

@interface BMAccountManager : NSObject

+ (instancetype)sharedInstance;
- (void)login;
- (void)logout;
- (BMUser *)currentUser;

//- (BMCacheData *)convertShareCookiesToCacheData;
//- (void)saveCookieToCache;
//- (void)loadCookie;
@end