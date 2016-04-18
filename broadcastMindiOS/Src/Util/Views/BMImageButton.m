//
//  BMImageButton.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/19/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMImageButton.h"

@implementation BMImageButton

- (void)drawRect:(CGRect)rect
{

    if (self.imageView.image) {
        CGFloat fontSize = self.titleLabel.font.pointSize;
        UIImage *image = self.imageView.image;
        image = [self imageWithImage:image convertToSize:CGSizeMake(fontSize, fontSize)];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self setImage:image forState:UIControlStateNormal];
    }
    [super drawRect:rect];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
@end
