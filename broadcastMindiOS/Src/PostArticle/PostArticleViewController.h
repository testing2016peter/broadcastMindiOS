//
//  PostArticleViewController.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseViewController.h"
@class PostArticleViewController;
@protocol PostArticleViewControllerDelegate <NSObject>
- (void)tapPostArticleViewController:(PostArticleViewController *)vc cancelButton:(id)cancelButton;
- (void)tapPostArticleViewController:(PostArticleViewController *)vc sendButton:(id)sendButton;

@end
@interface PostArticleViewController : BMBaseViewController
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) id <PostArticleViewControllerDelegate> postArticleViewControllerDelegate;

@end
