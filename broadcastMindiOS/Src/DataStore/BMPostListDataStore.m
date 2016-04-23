//
//  BMArticleListDataStore.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMPostListDataStore.h"
@interface BMPostListDataStore()
@property (strong, nonatomic) NSMutableDictionary *criteria;
@end
@implementation BMPostListDataStore
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.criteria = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)fetchDataWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [[self service] getArticleListWithParameter:nil range:NSMakeRange(self.start, 20) success:success failure:failure];
}

- (void)populateDataWithResponse:(id)response
{

    BMPostList *bmPostList = response;
    self.total = [bmPostList.total integerValue];
    [self.data addObjectsFromArray:bmPostList.posts];
    self.start = self.data.count;
}

- (void)loadNextBunchWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self beginWithSuccess:success failure:failure];
}
@end