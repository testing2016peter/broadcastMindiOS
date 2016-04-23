//
//  BMArticleListDataStore.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMArticleListDataStore.h"

@implementation BMArticleListDataStore
- (void)fetchDataWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [[self service] getArticleListWithParameter:nil range:NSMakeRange(self.start, 20) success:success failure:failure];
}

- (void)populateDataWithResponse:(id)response
{
    BMArticleList *bmArticleList = response;
    [self.data addObjectsFromArray:bmArticleList.articles];
    self.start = self.data.count;
}

- (void)loadNextBunchWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure
{
    [self beginWithSuccess:success failure:failure];
     }
@end
