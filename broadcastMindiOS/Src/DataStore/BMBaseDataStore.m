//
//  BMBaseDataStore.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseDataStore.h"
#import "BMService.h"

@implementation BMBaseDataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)beginWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self fetchDataWithSuccess:^(AFHTTPRequestOperation *operation, id response) {

        [self populateDataWithResponse:response];
        success(operation, response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {

        failure(operation, err);
    }];
}


- (void)reloadWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    self.start = 0;

    [self fetchDataWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        [self.data removeAllObjects];
        [self populateDataWithResponse:response];

        success(operation, response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {

        failure(operation, err);
    }];
}

- (void)loadNextBunchWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [NSException raise:@"Subclass should implmenet this" format:@"Subclass should implement this"];
}

- (void)fetchDataWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [NSException raise:@"Subclass should implmenet this" format:@"Subclass should implement this"];
}

- (void)populateDataWithResponse:(id)response
{
    if ([response isKindOfClass:[NSArray class]]) {
        [self.data addObjectsFromArray:response];
    } else {
        [self.data addObject:response];
    }
}

- (BMService *)service
{
    return [BMService sharedInstance];
}
@end
