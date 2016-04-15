//
//  APTripFinderClient.h
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^APClientSuccessBlock)(NSURLSessionTask *operation, id response);
typedef void(^APClientFailureBlock)(NSURLSessionTask *operation, NSError *err);

@interface BMClient : NSObject

+ (instancetype )sharedInstance;


@end
