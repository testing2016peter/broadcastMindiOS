//
//  BMArticleListCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMPostCollectionViewCell.h"

@implementation BMPostCollectionViewCell

- (void)setupView
{
    self.layer.masksToBounds = NO;

    [self.layer setShadowOpacity:0.4];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 1.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3f;

    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentTextView.text = @"";
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (CGSize)sizeForWidth:(CGFloat)width text:(NSString *)text
{
    self.cellWidthConstraint.constant = width;
    self.contentTextView.text = text;
    CGSize textViewSize = [self.contentTextView sizeThatFits:CGSizeMake(self.contentTextView.frame.size.width, FLT_MAX)];
    self.contentTextHeightConstraint.constant = textViewSize.height;
    [self setNeedsLayout];
    [self layoutIfNeeded];

    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

@end
