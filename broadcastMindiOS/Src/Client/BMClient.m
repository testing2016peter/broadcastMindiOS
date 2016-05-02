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

- (void)uploadImage:(UIImage *)image success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure process:(BMClientProcessBlock)process

{
    static NSInteger increment = 0;
    increment++;
    NSString *imageName = [NSString stringWithFormat:@"image_%ld.jpg", (long)increment];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *dataToPost = [NSMutableDictionary dictionary];
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];

    // 2. Create an `NSMutableURLRequest`.
    NSString *host = self.config.apiHostString;
    ///v1/post/:postId/comment
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host, @"/v1/upload"];
    NSError *err;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dataToPost constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"attachment"
                                fileName:imageName
                                mimeType:@"image/jpeg"];
    } error:&err];


    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSLog(@"Success %@", responseObject);
                                         if (success) {
                                             success(operation, responseObject);
                                         }
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Failure %@", error.description);
                                         if (failure) {
                                             failure(operation, error);
                                         }
                                     }];

    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
        CGFloat processPercentage = totalBytesWritten / totalBytesExpectedToWrite;
        if (process) {
            process(processPercentage);
        }
    }];
    
    // 5. Begin!
    [operation start];

}
@end
