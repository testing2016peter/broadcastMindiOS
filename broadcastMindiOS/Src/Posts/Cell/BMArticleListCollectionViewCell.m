//
//  BMArticleListCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMArticleListCollectionViewCell.h"

@implementation BMArticleListCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{

    self.contentTextView.text = @"";
    self.backgroundUIView.layer.cornerRadius = 5;
    self.backgroundUIView.layer.masksToBounds = YES;
}

@end
