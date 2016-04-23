//
//  APTripFinderService.h
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMClient.h"
#import "BMObjects.h"
@interface BMService : NSObject

+ (instancetype )sharedInstance;
- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)insertArticleWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;

@end