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
- (void)insertArticleWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    //https://petertest2016.herokuapp.com/v1/data/post
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/data/post"];
    NSDictionary *parameter = @{
                                @"text": text
                                };
    [manager POST:urlString parameters:parameter success:success failure:failure];
}

- (void)getArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/data/posts"];
    NSMutableDictionary *queryParameter = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    queryParameter[@"offset"] = @(range.location);
    queryParameter[@"limit"] = @(range.length);
    [manager GET:urlString parameters:[queryParameter copy] success:success failure:failure];
}

- (void)getMyArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *host = self.config.apiHostString;
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@" ,host,@"/v1/users/me/posts"];
    NSMutableDictionary *queryParameter = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    queryParameter[@"offset"] = @(range.location);
    queryParameter[@"limit"] = @(range.length);
    [manager GET:urlString parameters:[queryParameter copy] success:success failure:failure];
}


@end
