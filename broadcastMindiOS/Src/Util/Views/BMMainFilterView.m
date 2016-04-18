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

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.articleNewButtonWidthContraint.constant = screenBounds.size.width / 3.0f;

}



- (IBAction)tapMeButton:(id)sender
{
    if ([self.bmMainFilterViewDelegate respondsToSelector:@selector(tapBMMainFilterView:meButton:)]) {
        [self.bmMainFilterViewDelegate  tapBMMainFilterView:self meButton:sender];
    }
}

- (IBAction)tapNewButton:(id)sender
{
    if ([self.bmMainFilterViewDelegate respondsToSelector:@selector(tapBMMainFilterView:newButton:)]) {
        [self.bmMainFilterViewDelegate  tapBMMainFilterView:self newButton:sender];
    }
}

- (IBAction)tapHotestButton:(id)sender
{
    if ([self.bmMainFilterViewDelegate respondsToSelector:@selector(tapBMMainFilterView:hotestButton:)]) {
        [self.bmMainFilterViewDelegate  tapBMMainFilterView:self hotestButton:sender];
    }
}

@end
