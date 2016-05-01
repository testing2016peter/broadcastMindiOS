//
//  BMCacheManager.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCacheManager : NSObject
+ (instancetype)sharedInstance;

- (void)setDataWithKey:(NSString *)key data:(id)data cacheSecDuration:(NSInteger)cacheSecDuration;
- (void)removeDataWithKey:(NSString *)key;
- (id)getDataWithKey:(NSString *)key;

@end
