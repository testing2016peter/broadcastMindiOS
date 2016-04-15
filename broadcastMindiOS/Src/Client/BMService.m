//
//  APTripFinderService.m
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import "BMService.h"

@interface BMService ()
@property (strong, nonatomic) BMClient *client;
@end
@implementation BMService

+ (instancetype )sharedInstance
{
    static BMService *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMService alloc] init];
            instance.client = [BMClient sharedInstance];
        }
    });
    return instance;
}

@end
