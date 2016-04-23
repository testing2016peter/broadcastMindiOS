//
//  APTripFinderClient.h
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "BMAppConstant.h"

typedef void(^BMClientSuccessBlock)(AFHTTPRequestOperation *operation, id response);
typedef void(^BMClientFailureBlock)(AFHTTPRequestOperation *operation, NSError *err);

@interface BMClient : NSObject

+ (instancetype )sharedInstance;
- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)insertArticleWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getMyArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
@end
