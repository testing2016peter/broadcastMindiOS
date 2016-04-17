//
//  BMEnvConfig.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMEnvConfig.h"
@interface BMEnvConfig()

@property (assign, nonatomic) BMEnv env;

@end

@implementation BMEnvConfig

+ (instancetype)shareInstance
{
    static BMEnvConfig *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMEnvConfig alloc] init];
        }
    });

    return instance;
}

- (NSString *)apiHostString
{
    NSString *url = @"";
    switch (self.env) {
        case BMEnvProduction:
            url = BMEnvProductionApiUrl;
            break;
        case BMEnvBeta:
        default:
            url = BMEnvBetaApiUrl;
            break;
            
    }

    return url;
}
- (void)setupEnv:(BMEnv)env
{
    self.env = env;
}

@end
