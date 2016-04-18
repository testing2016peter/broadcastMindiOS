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
    [[self service] getArticleListWithSuccess:success failure:failure];
}

- (void)populateDataWithResponse:(id)response
{
    BMArticleList *bmArticleList = response;
    [self.data addObjectsFromArray:bmArticleList.articles];
}
@end
