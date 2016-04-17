//
//  BMCommonViewUtil.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMCommonViewUtil.h"

@implementation BMCommonViewUtil

+ (UIButton *)floatingButtonWithView:(UIView *)view image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage alpha:(CGFloat)alpha target:(nullable id)target action:(SEL)action
{
    CGRect spec = CGRectMake(view.frame.size.width - 72.0f, view.frame.size.height - 90.0f, backgroundImage.size.width, backgroundImage.size.height);
    UIButton *floatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [floatingButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [floatingButton setImage:image forState:UIControlStateNormal];
    floatingButton.frame = spec;
    [floatingButton setAlpha: alpha];
    [floatingButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //floatingButton.backgroundColor = [UIColor whiteColor];
    
    return floatingButton;
}
@end
