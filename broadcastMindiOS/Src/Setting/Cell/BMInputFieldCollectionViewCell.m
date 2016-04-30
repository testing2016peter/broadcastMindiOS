//
//  BMInputFieldCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInputFieldCollectionViewCell.h"

@implementation BMInputFieldCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    self.inputLabel.text = @"";
    self.inputTextField.text = @"";
}
@end
