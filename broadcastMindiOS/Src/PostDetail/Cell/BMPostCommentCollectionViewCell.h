//
//  BMPostCommentCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/27/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseCollectionViewCell.h"
static NSString * const BMPostCommentCollectionViewCellIdentifier = @"BMPostCommentCollectionViewCell";

@interface BMPostCommentCollectionViewCell : BMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTextViewHeightConstraint;

- (CGSize)sizeForWidth:(CGFloat)width text:(NSString *)text;
@end
