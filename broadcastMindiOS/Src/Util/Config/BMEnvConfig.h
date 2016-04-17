//
//  BMEnvConfig.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMAppConstant.h"
@interface BMEnvConfig : NSObject
+ (instancetype)shareInstance;
- (void)setupEnv:(BMEnv)env;
- (NSString *)apiHostString;
@end
