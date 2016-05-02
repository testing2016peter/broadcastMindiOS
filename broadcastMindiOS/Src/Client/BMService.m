//
//  APTripFinderService.m
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import "BMService.h"
#import "BMTrackUtil.h"

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

- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client signUpUserEmail:email password:password success:^(AFHTTPRequestOperation *operation, id response) {
                NSError *err;
        BMUser *user = [[BMUser alloc] initWithDictionary:response error:&err];
        if (success) {
            success(operation, user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}
- (void)getMeProfileWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client getMeProfileWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        NSError *err;
        BMUser *user = [[BMUser alloc] initWithDictionary:response error:&err];
        if (success) {
            success(operation, user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}

- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client loginUserEmail:email password:password success:^(AFHTTPRequestOperation *operation, id response) {
        NSError *err;
        BMUser *user = [[BMUser alloc] initWithDictionary:response error:&err];
        if (success) {
            success(operation, user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}
- (void)logoutUserWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client logoutUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            success(operation, response);
        }    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
            if (failure) {
                failure(operation, err);
            }
        }];
}

- (void)getPostListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client getPostListWithParameter:parameter range:range success:^(AFHTTPRequestOperation *operation, id response) {
        NSError *err;
        BMPostList *bmArticleList = [[BMPostList alloc] initWithDictionary:response error:&err];
        if (success) {
            success(operation, bmArticleList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}

- (void)insertPostWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client insertPostWithText:text success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}
- (void)getPostWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client getPostWithPostId:postId success:^(AFHTTPRequestOperation *operation, id response) {
        //TODO
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];

}

- (void)insertPostCommentWithPostId:(NSString *)postId text:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client insertPostCommentWithPostId:postId text:text success:^(AFHTTPRequestOperation *operation, id response) {
        //TODO
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}
- (void)getCommentWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client getCommentWithCommentId:commentId success:^(AFHTTPRequestOperation *operation, id response) {
        //TODO
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];

}

- (void)insertPostLikeWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client insertPostLikeWithPostId:postId success:^(AFHTTPRequestOperation *operation, id response) {
        //TODO
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];

}

- (void)insertCommentLikeWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client insertCommentLikeWithCommentId:commentId success:^(AFHTTPRequestOperation *operation, id response) {
        //TODO
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];

}

- (void)uploadImage:(UIImage *)image success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure process:(BMClientProcessBlock)process
{
    [self.client uploadImage:image success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    } process:^(CGFloat processPercentage) {
        if (process) {
            process(processPercentage);
        }
    }];
}

@end
