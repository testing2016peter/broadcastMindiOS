//
//  BMArticleListCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseCollectionViewCell.h"
#import "BMArticleFunctionView.h"
static NSString * const BMPostCollectionViewCellIdentifier = @"BMPostCollectionViewCell";

@interface BMPostCollectionViewCell : BMBaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet BMArticleFunctionView *bmArticleFunctionView;
@property (weak, nonatomic) IBOutlet UIView *backgroundUIView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextHeightConstraint;

- (CGSize)sizeForWidth:(CGFloat)width text:(NSString *)text;

@end