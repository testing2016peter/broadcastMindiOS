//
//  APTripFinderClient.m
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import "BMClient.h"
@interface BMClient ()

@end

@implementation BMClient
+ (instancetype )sharedInstance
{
    static BMClient *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMClient alloc] init];
        }
    });

    return instance;
}


@end
