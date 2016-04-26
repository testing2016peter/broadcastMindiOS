//
//  PostArticleViewController.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseViewController.h"
#import "BMPlaceholderTextView.h"
@class BMInsertPostViewController;

@protocol BMPostArticleViewControllerDelegate <NSObject>

- (void)tapPostArticleViewController:(BMInsertPostViewController *)vc cancelButton:(id)cancelButton;
- (void)tapPostArticleViewController:(BMInsertPostViewController *)vc sendButton:(id)sendButton;

@end

@interface BMInsertPostViewController : BMBaseViewController
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet BMPlaceholderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) id <BMPostArticleViewControllerDelegate> postArticleViewControllerDelegate;

@end
