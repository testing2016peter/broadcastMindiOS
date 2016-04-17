//
//  BMBaseDataStore.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMService.h"

@interface BMBaseDataStore : NSObject
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger start;
- (BMService *)service;

- (void)beginWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)reloadWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;
- (void)loadNextBunchWithSuccess:(BMClientSuccessBlock)success failure:(BMClientFailureBlock)failure;

@end
