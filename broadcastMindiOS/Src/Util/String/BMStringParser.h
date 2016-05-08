//
//  BMStringParser.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/8/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMStringParser : NSObject
+ (NSRange)nonImageURLStringRangeWithString:(NSString *)string;
+ (NSArray *)imageURLStringsRangeWithString:(NSString *)string;
@end
