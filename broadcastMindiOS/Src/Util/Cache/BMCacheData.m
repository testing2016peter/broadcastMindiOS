//
//  EACacheData.m
//  ECAuctionApp
//
//  Created by Anson Ng on 6/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "BMCacheData.h"


@interface BMCacheData ()

@property (strong, nonatomic) NSString *createTime;

@end

@implementation BMCacheData

-(instancetype) init
{
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.createTime = [coder decodeObjectOfClass:[NSString class] forKey:@"createTime"];
        self.expireSec = [coder decodeObjectOfClass:[NSString class] forKey:@"expireSec"];
        @try {
            self.dataClassNames = [coder decodeObjectOfClass:[NSSet class] forKey:@"dataClassNames"];
            if ([self.dataClassNames count] > 0) {
                NSMutableSet *decodeSet = [[NSMutableSet alloc] initWithSet:self.dataClassNames];
                NSMutableSet *decodeClassSet = [NSMutableSet set];
                [decodeSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                    [decodeClassSet addObject:NSClassFromString(obj)];
                }];
                _data = [coder decodeObjectOfClasses:decodeClassSet forKey:@"data"];
            }
        }
        @catch (NSException *exception) {
            _data = nil;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.expireSec forKey:@"expireSec"];
    [coder encodeObject:self.createTime forKey:@"createTime"];
    [coder encodeObject:self.data forKey:@"data"];
    [coder encodeObject:self.dataClassNames forKey:@"dataClassNames"];
}

- (instancetype)initWithExprieSec:(NSTimeInterval)inputExpireSec
{
    NSTimeInterval tmpCreateTime = [[NSDate date] timeIntervalSince1970];
    self.createTime = [NSString stringWithFormat:@"%f", tmpCreateTime];
    self.expireSec  = [NSString stringWithFormat:@"%f", inputExpireSec];
    return [self init];
}

- (void)setData:(id)inputData
{
    _data = inputData;
    if (_data) {
        NSMutableSet *dataClassNames = [NSMutableSet set];
        [dataClassNames addObject:NSStringFromClass([_data class])];
        [dataClassNames addObject:NSStringFromClass([NSArray class ])];
        [dataClassNames addObject:NSStringFromClass([NSDictionary class])];
        [self addObjectsAddTypes:_data classNamesSet:dataClassNames];
        self.dataClassNames = [dataClassNames copy];
    }
}

- (void)addObjectsAddTypes:(id)checkData classNamesSet:(NSMutableSet *)classNamesSet
{
    if ([checkData isKindOfClass:[NSArray class]]) {
        for (id rowData in checkData) {
            [classNamesSet addObject:NSStringFromClass([rowData class])];
            if ([rowData isKindOfClass:[NSArray class]] || [rowData isKindOfClass:[NSDictionary class]] ) {
                [self addObjectsAddTypes:rowData classNamesSet:classNamesSet];
            }
        }
    } else {
        if ([checkData isKindOfClass:[NSDictionary class]]) {
            for (id name in checkData) {
                [classNamesSet addObject:NSStringFromClass([checkData[name] class])];
                if ([checkData[name] isKindOfClass:[NSArray class]] || [checkData[name]  isKindOfClass:[NSDictionary class]] ) {
                    [self addObjectsAddTypes:checkData[name] classNamesSet:classNamesSet];
                }
            }
        }
    }
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end