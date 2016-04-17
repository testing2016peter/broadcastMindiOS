//
//  YDKNibCacheManager.m
//  YDevelopKit
//
//  Created by Chih Feng Sung on 6/8/15.
//  Copyright (c) 2015 Yahoo-Inc. All rights reserved.
//

#import "APNibCacheManager.h"


@interface APKNibCacheManager ()

@property (nonatomic, strong) NSMutableDictionary *instanceDict;

@end


@implementation APKNibCacheManager

+ (instancetype)sharedInstance
{
    static APKNibCacheManager *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[APKNibCacheManager alloc] init];
            instance.instanceDict = [[NSMutableDictionary alloc] init];
        }
    });

    return instance;
}

- (instancetype)instanceForNibNamed:(NSString *)nibName
{
    id classInstance = nil;
    NSString *nibNameKey = [nibName stringByAppendingPathComponent:@"nib"];
    if ([self.instanceDict objectForKey:nibNameKey]) {
        classInstance = [self.instanceDict objectForKey:nibNameKey];
    } else {
        classInstance = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject];
        [self.instanceDict setObject:classInstance forKey:nibNameKey];
    }

    return classInstance;
}

- (instancetype)instanceForClassNamed:(NSString *)className
{
    id classInstance = nil;
    NSString *classNameKey = [classInstance stringByAppendingPathComponent:@"class"];
    if ([self.instanceDict objectForKey:classNameKey]) {
        classInstance = [self.instanceDict objectForKey:className];
    } else {
        classInstance = [[NSBundle mainBundle] classNamed:className];
        [self.instanceDict setObject:classInstance forKey:classNameKey];
    }

    return classInstance;
}



@end
