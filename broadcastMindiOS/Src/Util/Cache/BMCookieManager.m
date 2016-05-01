//
//  BMCookieManager.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMCookieManager.h"
#import "BMCacheData.h"

@implementation BMCookieManager

+ (BMCacheData *)cookieCacheData
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
@end
