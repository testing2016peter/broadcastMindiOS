//
//  BMMenuLogoutCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMMenuTextCollectionViewCell.h"

@implementation BMMenuTextCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImageView.image = nil;
    self.inputLabel.text = @"";
}
@end
