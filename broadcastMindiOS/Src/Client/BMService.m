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
        success(operation, response);
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
        success(operation, response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}

- (void)insertArticleWithText:(NSString *)text success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client insertArticleWithText:text success:^(AFHTTPRequestOperation *operation, id response) {

        success(operation, response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [BMTrackUtil logError:BMTrackErrorApi message:operation.responseString error:err];
        if (failure) {
            failure(operation, err);
        }
    }];
}

- (void)getArticleListWithParameter:(NSDictionary *)parameter range:(NSRange)range success:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self.client getArticleListWithParameter:parameter range:range success:^(AFHTTPRequestOperation *operation, id response) {
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
@end
