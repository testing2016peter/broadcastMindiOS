//
//  BMMenuUserCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMMenuUserCollectionViewCell.h"

@implementation BMMenuUserCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.userImageView.image = [UIImage imageNamed:@"Icon-User"];
    self.userNameLabel.text = @"Login";
}

@end
