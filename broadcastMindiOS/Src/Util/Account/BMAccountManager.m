//
//  BMAccountManager.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMAccountManager.h"
#import "BMService.h"
#import "BMCacheData.h"
#import "BMCacheManager.h"
@interface BMAccountManager ()
@property (strong, nonatomic) BMUser *currentUser;
@end
@implementation BMAccountManager
+ (instancetype)sharedInstance
{
    static BMAccountManager *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMAccountManager alloc] init];
        }
    });

    return instance;
}

- (void)loginUserEmail:(NSString *)email password:(NSString *)password
{
    __weak __typeof(self)weakSelf = self;
    [[BMService sharedInstance] loginUserEmail:email password:password success:^(AFHTTPRequestOperation *operation, id response) {
        self.currentUser = response;
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginSuccessNotification object:weakSelf];

    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginFailNotification object:weakSelf];
    }];
}

- (void)logout
{
    __weak __typeof(self)weakSelf = self;
    [[BMService sharedInstance] logoutUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        self.currentUser = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLogoutSuccessNotification object:weakSelf];

    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLogoutFailNotification object:weakSelf];

    }];
}

- (BMUser *)currentUser
{
    return _currentUser;
}

- (BMCacheData *)convertShareCookiesToCacheData
{
    NSArray* allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSMutableArray *cookieList = [NSMutableArray array];
    for (NSHTTPCookie *cookie in allCookies) {
        [cookieList addObject: cookie.properties];
    }
    BMCacheData *cacheData = [[BMCacheData alloc] initWithExprieSec:100];
    cacheData.data = [cookieList copy];
    return cacheData;
}

- (void)saveCookieToCache
{
    BMCacheData *data = [self convertShareCookiesToCacheData];
    [[BMCacheManager sharedInstance] setDataWithKey:@"cacheCookies" data:data cacheSecDuration:999];
}

- (void)loadCookie
{
    BMCacheData *data = [[BMCacheManager sharedInstance] getDataWithKey:@"cacheCookies"];
    NSArray *cookiesPropertiesList = data.data;
    [cookiesPropertiesList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull cookieProperties, NSUInteger idx, BOOL * _Nonnull stop) {
        NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];

}

@end
