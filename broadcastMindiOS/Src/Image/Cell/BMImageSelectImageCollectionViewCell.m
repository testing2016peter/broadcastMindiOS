//
//  BMImageSelectImageCollectionViewCell.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/7/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMImageSelectImageCollectionViewCell.h"
#import "UIImage+BMImage.h"
#import "UIColor+BMColor.h"
@interface BMImageSelectImageCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *isSelectImageView;

@end

@implementation BMImageSelectImageCollectionViewCell

- (void)setupView
{
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
    self.selected = NO;
}

- (void)setSelected:(BOOL)selected
{
    super.selected = selected;
    if (selected == YES) {
        self.isSelectImageView.image = [UIImage image:[UIImage imageNamed:@"Icon-Check-Empty"] replaceColor:[UIColor BMImageSelectedColor]];
    } else {
        self.isSelectImageView.image = [UIImage image:[UIImage imageNamed:@"Icon-Check-Empty"] replaceColor:[UIColor BMImageNonSelectColor]];
    }
}

@end
