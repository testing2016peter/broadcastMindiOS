//
//  BMConstraintUtil.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/22/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMConstraintUtil.h"

@implementation BMConstraintUtil
+ (void)addTopZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView
{

    [targetView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:targetView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:parentView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant: 0.0f];
    [parentView addConstraint:topConstraint];


}
+ (void)addBottomZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView
{

    [targetView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint
                                            constraintWithItem:targetView
                                            attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:parentView
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0f
                                            constant: 0.0f];
    [parentView addConstraint:bottomConstraint];
}
+ (void)addLeadingZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView
{

    [targetView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *leadConstraint = [NSLayoutConstraint
                                          constraintWithItem:targetView
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:parentView
                                          attribute:NSLayoutAttributeLeading
                                          multiplier:1.0f
                                          constant:0.0f];

    [parentView addConstraint:leadConstraint];
}

+ (void)addTrailingZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView
{

    [targetView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint
                                              constraintWithItem:targetView
                                              attribute:NSLayoutAttributeTrailing
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:parentView
                                              attribute:NSLayoutAttributeTrailing
                                              multiplier:1.0f
                                              constant: 0.0f];
    [parentView addConstraint:trailingConstraint];
}


+ (void)addAllZeroConstraintWithParentView:(UIView *)parentView targetView:(UIView *)targetView
{
    [BMConstraintUtil addTopZeroConstraintWithParentView:parentView targetView:targetView];
    [BMConstraintUtil addBottomZeroConstraintWithParentView:parentView targetView:targetView];
    [BMConstraintUtil addLeadingZeroConstraintWithParentView:parentView targetView:targetView];
    [BMConstraintUtil addTrailingZeroConstraintWithParentView:parentView targetView:targetView];
}
@end
