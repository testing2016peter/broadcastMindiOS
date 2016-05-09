//
//  BMStringParser.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/8/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMStringParser.h"

@implementation BMStringParser
+ (NSRange)nonImageURLStringRangeWithString:(NSString *)string
{
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:string options:0 range:NSMakeRange(0, [string length])];

    __block NSRange returnRange = NSMakeRange(0, string.length);
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString = [[obj URL] absoluteString];
        if ([urlString containsString:@".jpg"] || [urlString containsString:@".jpeg"] || [urlString containsString:@".png"] || [urlString containsString:@".gif"]) {
            returnRange.length = obj.range.location - 1;
            *stop = YES;
        }

    }];
    return returnRange;
}

+ (NSArray *)imageURLStringsRangeWithString:(NSString *)string
{
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:string options:0 range:NSMakeRange(0, [string length])];


    NSMutableArray *imageURLStrings = [NSMutableArray array];
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString = [[obj URL] absoluteString];
        if ([urlString containsString:@".jpg"] || [urlString containsString:@".jpeg"] || [urlString containsString:@".png"] || [urlString containsString:@".gif"]) {
            [imageURLStrings addObject:urlString];
        }
        
    }];
    return [imageURLStrings copy];

}
@end
