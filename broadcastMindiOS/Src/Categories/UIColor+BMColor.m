//
//  UIColor+BMColor.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/16/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "UIColor+BMColor.h"
#import <MNColorKit/RGBX.h>
@implementation UIColor (BMColor)

+ (UIColor *)BMBackgroundColor
{
 //   return RGBX(0xF3F3F3);
    return RGBX(0x8e44ad);
}

+ (UIColor *)BMActionColor
{
    return RGBX(0x9b59b6);
}
@end
