//
//  BMInputTextView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/22/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseView.h"
#import "BMPlaceholderTextView.h"
@class BMInputTextView;
@protocol BMInputTextViewDelegate <NSObject>
- (void)didBMInputTextView:(BMInputTextView *)bmInputTextView changeSize:(CGSize )size;
@end

@interface BMInputTextView : BMBaseView
@property (weak, nonatomic) IBOutlet UIView *topLevelSubview;
@property (weak, nonatomic) IBOutlet BMPlaceholderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;
@property (assign, nonatomic) NSInteger maxTextCount;
@property (assign, nonatomic) CGFloat maxTextHeight;
@property (weak, nonatomic) id <BMInputTextViewDelegate> bmInputTextViewDelegate;
@end
