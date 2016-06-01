//
//  BMInsetLabel.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 6/2/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInsetLabel.h"

@implementation BMInsetLabel

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width  += self.edgeInsets.left + self.edgeInsets.right;
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return size;
}


@end
