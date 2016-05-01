//
//  BMPostCommentCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/27/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMPostCommentCollectionViewCell.h"

@implementation BMPostCommentCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.userImageView.image = [UIImage imageNamed:@"Icon-User"];
    self.userNameLabel.text = @"";
    self.timeLabel.text = @"";
    self.commentTextView.text = @"";
}

- (CGSize)sizeForWidth:(CGFloat)width text:(NSString *)text
{
    self.cellWidthConstraint.constant = width;
    self.commentTextView.text = text;
    CGSize textViewSize = [self.commentTextView sizeThatFits:CGSizeMake(self.commentTextView.frame.size.width, FLT_MAX)];
    self.commentTextViewHeightConstraint.constant = textViewSize.height;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}
@end
