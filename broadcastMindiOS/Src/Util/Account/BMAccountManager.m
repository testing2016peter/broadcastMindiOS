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
#import "BMLoginViewController.h"
static NSString * const BMAccountManagerUserKey = @"BMAccountManagerUserKey";
@interface BMAccountManager ()
@property (strong, nonatomic) BMUser *currentUser;
@property (strong, nonatomic) BMLoginViewController *bmLoginViewController;
@end
@implementation BMAccountManager
+ (instancetype)sharedInstance
{
    static BMAccountManager *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMAccountManager alloc] init];
            instance.currentUser = [[BMCacheManager sharedInstance] getDataWithKey:BMAccountManagerUserKey];
            __weak __typeof(instance)weakInstance = instance;

            [[BMService sharedInstance]getMeProfileWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
                [instance setupCurrentUser:response];
                [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginSuccessNotification object:weakInstance];
            } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
                [instance removeCurrentUser];
                [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginFailNotification object:weakInstance];
            }];
        }
    });

    return instance;
}

- (void)requestLoginWithParentViewController:(UIViewController *)parentViewController
{
    self.bmLoginViewController= [[BMLoginViewController alloc] init];
    [parentViewController presentViewController:self.bmLoginViewController animated:YES completion:nil];
}

- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    __weak __typeof(self)weakSelf = self;
    [[BMService sharedInstance] loginUserEmail:email password:password success:^(AFHTTPRequestOperation *operation, id response) {
        [weakSelf setupCurrentUser:response];
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginSuccessNotification object:weakSelf];
        if (success) {
            if (weakSelf.bmLoginViewController.presentedViewController) {
                [weakSelf.bmLoginViewController dismissViewControllerAnimated:YES completion:nil];
            }
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginFailNotification object:weakSelf];
        if (failure) {
            failure(operation, err);
        }
    }];
}

- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    __weak __typeof(self)weakSelf = self;
    [[BMService sharedInstance] signUpUserEmail:email password:password success:^(AFHTTPRequestOperation *operation, id response) {
        [self setupCurrentUser:response];
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginSuccessNotification object:weakSelf];
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLoginFailNotification object:weakSelf];
        if (failure) {
            failure(operation, err);
        }
    }];

}
- (void)logout
{
    __weak __typeof(self)weakSelf = self;
    [[BMService sharedInstance] logoutUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        [weakSelf removeCurrentUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLogoutSuccessNotification object:weakSelf];


    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMAccountManagerUserLogoutFailNotification object:weakSelf];

    }];
}
- (void)setupCurrentUser:(BMUser *)currentUser
{
    self.currentUser = currentUser;
    [[BMCacheManager sharedInstance] setDataWithKey:BMAccountManagerUserKey data:currentUser cacheSecDuration:999999999];
}
- (void)removeCurrentUser
{
    self.currentUser = nil;
    [[BMCacheManager sharedInstance] removeDataWithKey:BMAccountManagerUserKey];
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
