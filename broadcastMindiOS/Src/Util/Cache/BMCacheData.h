//
//  EACacheData.h
//  ECAuctionApp
//
//  Created by Anson Ng on 6/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCacheData : NSObject <NSSecureCoding>
{
    NSString *createTime;
    NSString *expireSec;
    id data;
}

- (instancetype)init;
- (instancetype)initWithExprieSec:(NSTimeInterval)inputExpireSec;

@property (readonly, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *expireSec;
@property (strong, nonatomic) NSSet *dataClassNames;
@property (strong, nonatomic) id data;

@end