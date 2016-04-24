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
typedef void(^BMClientProcessBlock)(CGFloat processPercentage);

@interface BMClient : NSObject

+ (instancetype )sharedInstance;
- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;

- (void)logoutUserWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)insertPostWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getPostWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getPostListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
///v1/post/:postId/comment
- (void)insertPostCommentWithPostId:(NSString *)postId text:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)getCommentWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;

- (void)insertPostLikeWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)insertCommentLikeWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;

- (void)uploadImage:(UIImage *)image success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure process:(BMClientProcessBlock)process;
@end
