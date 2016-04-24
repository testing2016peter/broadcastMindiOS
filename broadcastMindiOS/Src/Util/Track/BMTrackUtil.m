//
//  BMTrackUtil.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/24/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMTrackUtil.h"

@implementation BMTrackUtil

+ (void)startSession
{
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"Y9BTN83V9KVN75NC5MZZ"];
}

+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters
{
    [Flurry logEvent:@"" withParameters:@{}];
}

+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error
{
    [Flurry logError:errorID message:message error:error];
}

+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception
{
    [Flurry logError:errorID message:message exception:exception];
}

+ (void)setupUserId:(NSString *)userId
{
    [Flurry setUserID:userId];
}
@end
