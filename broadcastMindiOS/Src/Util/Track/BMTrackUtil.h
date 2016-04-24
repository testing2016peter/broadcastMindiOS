//
//  BMTrackUtil.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/24/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flurry.h>
@interface BMTrackUtil : NSObject
+ (void)startSession;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;
+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
+ (void)setupUserId:(NSString *)userId;
@end
