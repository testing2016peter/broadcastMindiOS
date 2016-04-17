//
//  BMMainFilterView.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMMainFilterView.h"

@implementation BMMainFilterView

- (void)afterLoadFromNibWithRect:(CGRect)rect
{
    CGRect frame =   self.articleNewButton.frame;
    frame.size.width = rect.size.width / 3;
    self.articleNewButton.frame = frame;
}

@end
