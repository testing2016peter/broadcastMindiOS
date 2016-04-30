//
//  PostArticleViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInsertPostViewController.h"
#import "BMService.h"

@interface BMInsertPostViewController ()

@end

@implementation BMInsertPostViewController

- (void)setupView
{
    self.contentTextView.placeholderColor = [UIColor blueColor];
    self.contentTextView.placeholderString = @"靠北事件";//

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
    [self.contentTextView becomeFirstResponder];

}
- (IBAction)tapCancelButton:(id)sender
{
        [self.contentTextView resignFirstResponder];
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:cancelButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self cancelButton:self.cancelButton];

    }
}

- (IBAction)tapSendButton:(id)sender
{
    [self.contentTextView resignFirstResponder];
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:sendButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self sendButton:self.sendButton];

    }
}
- (IBAction)logout:(id)sender
{
    [[BMService sharedInstance] logoutUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"logout:%@", response);

    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {

        NSLog(@"err:%@" , err);
        NSLog(@"err:%@" , err);
        NSLog(@"err:%@" , err);
    }];

}

@end
