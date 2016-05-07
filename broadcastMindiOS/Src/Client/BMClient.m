//
//  APTripFinderClient.m
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import "BMClient.h"
#import "BMEnvConfig.h"

@interface BMClient ()
@property (strong, nonatomic) BMEnvConfig *config;
@end

@implementation BMClient
+ (instancetype )sharedInstance
{
    static BMClient *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[BMClient alloc] init];
            instance.config = [BMEnvConfig shareInstance];
        }
    });

    return instance;
}

- (void)signUpUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/users/signup"];
    NSDictionary *parameter = @{
                                @"email": email,
                                @"password": password
                                };
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)loginUserEmail:(NSString *)email password:(NSString *)password success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/users/login"];
    NSDictionary *parameter = @{
                                @"email": email,
                                @"password": password
                                };
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)getMeProfileWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/users/me"];

    [manager GET:urlString parameters:nil success:success failure:failure];
}

- (void)logoutUserWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/users/logout"];
    NSDictionary *parameter = nil;
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)insertPostWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    //https://petertest2016.herokuapp.com/v1/data/post
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/posts"];
    NSDictionary *parameter = @{
                                @"text": text
                                };
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)getPostWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@" ,host,@"/v1/posts", postId];

    [manager GET:urlString parameters:nil success:success failure:failure];
}

- (void)getPostListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/posts"];
    NSMutableDictionary *queryParameter = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    queryParameter[@"offset"] = @(range.location);
    queryParameter[@"limit"] = @(range.length);
    [manager GET:urlString parameters:[queryParameter copy] success:success failure:failure];
}

- (void)insertPostCommentWithPostId:(NSString *)postId text:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    ///v1/post/:postId/comment
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@/%@/%@" ,host,@"/v1/posts", postId, @"comment"];
    NSDictionary *parameter = @{
                                @"text": text
                                };
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)getCommentWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@/%@" ,host,@"/v1/comment", commentId];

    [manager GET:urlString parameters:nil success:success failure:failure];
}

- (void)insertPostLikeWithPostId:(NSString *)postId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    ///v1/post/:postId/comment
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@/%@/%@" ,host, @"/v1/post", postId, @"like"];

    [manager POST:urlString parameters:nil success:success failure:failure];
}

- (void)insertCommentLikeWithCommentId:(NSString *)commentId success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    ///v1/comment/:commentId/like
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@/%@/%@" ,host, @"/v1/comment/", commentId, @"like"];
    [manager POST:urlString parameters:nil success:success failure:failure];
}

- (void)uploadImage:(UIImage *)image progress:(NSProgress **)progress success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host, @"/v1/upload"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];

    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:progress
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          failure(nil, error);
                      } else {
                          success(nil, [[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil] description]);
                      }
                  }];

    [uploadTask resume];

    //    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    //    
    
}
@end
