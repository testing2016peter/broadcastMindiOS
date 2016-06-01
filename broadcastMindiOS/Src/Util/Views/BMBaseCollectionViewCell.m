//
//  BMBaseCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseCollectionViewCell.h"
#import "UIColor+BMColor.h"
@implementation BMBaseCollectionViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupComponent];
    [self setupView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self setupComponent];
        [self setupView];
    }

    return self;
}

- (void)setupView
{
}


- (void)setupComponent
{
    self.borderLayer = [CALayer layer];
    self.borderLayer.backgroundColor = [UIColor BMBorderColor].CGColor;
    self.borderHidden = YES;
    self.topBorderLayer = [CALayer layer];
    self.topBorderLayer.backgroundColor = [UIColor BMBorderColor].CGColor;
    self.topBorderHidden = YES;//default

    [self.contentView.layer addSublayer:self.borderLayer];
    [self.contentView.layer addSublayer:self.topBorderLayer];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.borderLayer.backgroundColor = borderColor.CGColor;
}

- (void)setBorderHidden:(BOOL)borderHidden
{
    _borderHidden = borderHidden;
    self.borderLayer.hidden = borderHidden;
}

- (void)setTopBorderHidden:(BOOL)topBorderHidden
{
    _topBorderHidden = topBorderHidden;
    self.topBorderLayer.hidden = topBorderHidden;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat borderWidth = CGRectGetWidth(self.frame) - self.leadingMargin - self.tailingMargin;
    CGFloat topBorderBorderWidth = CGRectGetWidth(self.frame) - self.topBorderLeadingMargin - self.topBorderTailingMargin;
    CGFloat borderHeight = (self.borderHeight) ? self.borderHeight : 1.0f;
    
    CGFloat borderX = self.leadingMargin;
    CGFloat topBorderBorderX = self.topBorderLeadingMargin;

    CGFloat borderY = CGRectGetHeight(self.frame) - borderHeight;

    [CATransaction begin];
    [CATransaction setValue:@(YES) forKey:kCATransactionDisableActions];
    self.borderLayer.frame = CGRectMake(borderX, borderY, borderWidth, borderHeight);
    self.topBorderLayer.frame = CGRectMake(topBorderBorderX, 0.0f, topBorderBorderWidth, borderHeight);
    [CATransaction commit];
}


@end
