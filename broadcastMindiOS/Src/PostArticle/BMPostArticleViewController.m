//
//  PostArticleViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMPostArticleViewController.h"

@interface BMPostArticleViewController ()

@end

@implementation BMPostArticleViewController

- (void)setupView
{
    self.containerView.layer.cornerRadius = 5;
    self.containerView.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor clearColor];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self.view addSubview:blurEffectView];
        [self.view bringSubviewToFront:self.containerView];
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
    }

}
- (IBAction)tapCancelButton:(id)sender
{
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:cancelButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self cancelButton:self.cancelButton];

    }
}

- (IBAction)tapSendButton:(id)sender
{
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:sendButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self sendButton:self.sendButton];

    }
}

@end
