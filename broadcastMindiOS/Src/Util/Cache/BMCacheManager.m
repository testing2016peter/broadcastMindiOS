//
//  BMCacheManager.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMCacheManager.h"
#import "BMCacheData.h"
static NSString * const keySetName = @"BMCacheManagerAllKeys";

@interface BMCacheManager ()
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@end

@implementation BMCacheManager
+ (instancetype)sharedInstance
{
    static BMCacheManager *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMCacheManager alloc]init];
        }
    });
    return instance;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;

}
- (void)setDataWithKey:(NSString *)key data:(id)data cacheSecDuration:(NSInteger)cacheSecDuration
{
    BMCacheData *cacheData = [[BMCacheData alloc] initWithExprieSec:cacheSecDuration];
    cacheData.data = data;
    cacheData.data = data;
    NSData *archiverCacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheData];
    NSMutableData *mutableData = [[NSMutableData alloc] init];

    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    archiver.requiresSecureCoding = YES;
    [archiver encodeObject:cacheData forKey:@"BMCacheManager"];
    [archiver finishEncoding];


    [self.userDefaults setObject:mutableData forKey:key];
    [self.userDefaults synchronize];
    [BMCacheManager insertKeyListsKey:key];
}

- (void)removeDataWithKey:(NSString *)key
{
    [self.userDefaults removeObjectForKey:key];
}

- (id)getDataWithKey:(NSString *)key
{
    id returnData = nil;
    @try {
        if (key && [self.userDefaults objectForKey:key]) {

            NSMutableData *mutableData = [self.userDefaults objectForKey:key];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:mutableData];
            unarchiver.requiresSecureCoding = YES;
            BMCacheData *cacheData  =  (BMCacheData *) [unarchiver decodeObjectOfClass:[BMCacheData class] forKey:@"BMCacheManager"];
            [unarchiver finishDecoding];
            NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
            NSTimeInterval createTime = [cacheData.createTime doubleValue];
            NSTimeInterval expireSec = [cacheData.expireSec doubleValue];

            if (currentTime <= (createTime + expireSec)) {
                returnData = cacheData.data;
            } else {
                [self.userDefaults removeObjectForKey:key];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@", exception);
    }
    return returnData;

}

+ (void)insertKeyListsKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *keys = [[NSMutableArray alloc]initWithArray:[BMCacheManager getKeys]];
    if (![keys containsObject:key]) {
        [keys addObject:key];
        NSString *dateKey =keySetName;
        [userDefaults setObject:[keys copy] forKey:dateKey];
    }
}

+ (void)removeKeyListsKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *keys = [[NSMutableArray alloc]initWithArray:[BMCacheManager getKeys]];
    if (![keys containsObject:key]) {
        [keys removeObject:key];
        NSString *dateKey =keySetName;
        [userDefaults setObject:[keys copy] forKey:dateKey];
    }
}

+ (NSArray *)getKeys
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = [[NSArray alloc] init];
    if ([userDefaults objectForKey:keySetName]) {
        keys = [userDefaults objectForKey:keySetName];
    }
    return keys;
}


@end
