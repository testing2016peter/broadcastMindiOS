//
//  BMConstraintUtil.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/22/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BMConstraintUtil : NSObject

+ (void)addTopZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView;
+ (void)addBottomZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView;
+ (void)addLeadingZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView;
+ (void)addTrailingZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView;
+ (void)addAllZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView;



@end
