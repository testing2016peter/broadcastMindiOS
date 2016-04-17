//
//  BMCommonViewUtil.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BMCommonViewUtil : NSObject

+ (UIButton *)floatingButtonWithView:(UIView *)view image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage alpha:(CGFloat)alpha target:(nullable id)target action:(SEL)action;
@end
