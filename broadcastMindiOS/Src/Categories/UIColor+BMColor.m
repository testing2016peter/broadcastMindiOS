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

+ (UIColor *)BMNavBackgroundColor
{
    //   return RGBX(0xF3F3F3);
    return RGBX(0x282323);
}
+ (UIColor *)BMBackgroundColor
{
 //   return RGBX(0xF3F3F3);
    return RGBX(0xF1F0F0);
}

+ (UIColor *)BMActionColor
{
    return RGBX(0x9b59b6);
}

+ (UIColor *)BMImageNonSelectColor
{
    return RGBX(0xDCDCDC);
}

+ (UIColor *)BMImageSelectedColor
{
    return RGBX(0x85be63);
}

+ (UIColor *)BMBorderColor
{
    return [RGBX(0x000000) colorWithAlphaComponent:0.1];
}

+ (UIColor *)BMRoundLabelColor
{
    return RGBX(0xF6F6F6);
}

+ (UIColor *)BMTimeLabelColor
{
    return RGBX(0xB2B2B2);
}

+ (UIColor *)BMTabbarSelectedColor
{
    return RGBX(0x5DADE2);
}
@end