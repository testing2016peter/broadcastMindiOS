//
//  BMUser.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMUser.h"

@implementation BMUser
- (NSString *)dispalyName
{
    if ([self.nickname length] > 0) {
        return self.nickname;
    }
    return self.email;
}

@end
