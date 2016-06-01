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
    //    self.layer.masksToBounds = NO;
    //    [self.layer setShadowOpacity:0.4];
    //    self.layer.shadowOffset = CGSizeMake(0, 1);
    //    self.layer.shadowRadius = 1.0f;
    //    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //    self.layer.shadowOpacity = 0.3f;

    self.leadingMargin = 0.0f;
    self.tailingMargin = 0.0f;

    [self setupNumberLabel:self.commentLabel];
    [self setupNumberLabel:self.likeLabel];
    [self setupNumberLabel:self.shareLabel];
    self.borderLayer.hidden = NO;
    [self prepareForReuse];
}

-(void)setupNumberLabel:(BMInsetLabel *)label
{
    label.backgroundColor = [UIColor BMRoundLabelColor];
    label.layer.cornerRadius = 4.0f;
    label.edgeInsets = UIEdgeInsetsMake(0.0f, 8.0f, 0.0f,  8.0f);
    label.layer.masksToBounds = YES;

}
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentTextView.text = @"";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    //    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (CGSize)sizeForWidth:(CGFloat)width text:(NSString *)text
{
    self.bounds = CGRectMake(0, 0, width,  self.bounds.size.height);
    self.cellWidthConstraint.constant = width;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.contentTextView.text = text;
    CGSize textViewSize = [self.contentTextView sizeThatFits:CGSizeMake(self.contentTextView.frame.size.width, FLT_MAX)];
    self.contentTextHeightConstraint.constant = textViewSize.height;
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (IBAction)tapCommentButton:(id)sender
{
    self.commentButton.selected = !self.commentButton.selected;
}

- (IBAction)tapLikeButton:(id)sender
{
    self.likeButton.selected = !self.likeButton.selected;
}

- (IBAction)tapShareButton:(id)sender
{
    self.shareButton.selected = !self.shareButton.selected;
}

@end
