//
//  BMInputTextView.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/22/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInputTextView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
static const NSString *  BMInputTextViewContentTextViewContentSize = @"BMInputTextViewContentTextViewContentSize";

@interface BMInputTextView  ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextTopConstraint;

@end
@implementation BMInputTextView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupView
{
    self.contentTextView.placeholderString = @"test";
    self.contentTextView.placeholderColor = [UIColor blueColor];
    self.contentTextView.placeholderAligment =  self.contentTextView.textAlignment;
    if (self.maxTextCount == 0) {
        self.maxTextCount = 250;
    }
    if (self.maxTextHeight == 0.0f) {
        self.maxTextHeight = self.contentTextView.font.pointSize * 3;
    }
    //    [[self.contentTextView.rac_textSignal
    //      filter:^BOOL(id value) {
    //          NSString *text = value; // implicit cast
    //          NSLog(@"filter:%d", text.length);
    //
    //          if (text.length > self.maxTextCount) {
    //                        self.contentTextView.text = nsstr
    //          }
    //          self.contentTextView.text = text;
    //          return text.length <=self.maxTextCount;
    //      }]
    //     subscribeNext:^(id x) {
    //
    //         NSString *text = x; // implicit cast
    //         NSLog(@"subscribeNext:%d", text.length);
    //
    //         self.textCountLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.contentTextView.text.length, (long)self.maxTextCount];
    //
    //     }];

    RAC(self.contentTextView, text) = [self validatedTextWithSignal:self.contentTextView.rac_textSignal];
    [self.contentTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:&BMInputTextViewContentTextViewContentSize];

}

- (RACSignal *)validatedTextWithSignal:(RACSignal *)signal {

    NSUInteger kMaxLength = self.maxTextCount;

    return [signal map:^id(NSString *text) {
        if (text.length == 0) {
            self.sendButton.enabled = NO;
        } else {
            self.sendButton.enabled = YES;
        }
        NSString *returnText =  text.length <= kMaxLength ? text : [text substringToIndex:kMaxLength];
        self.textCountLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)returnText.length, (long)self.maxTextCount];

        return returnText;
    }];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == &BMInputTextViewContentTextViewContentSize) {
        CGSize newSize =  [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];


        if ([self.bmInputTextViewDelegate respondsToSelector:@selector(didBMInputTextView:changeSize:)]) {

            CGFloat height = MIN(newSize.height, self.maxTextHeight);
            CGFloat orgHeight = CGRectGetHeight(self.contentTextView.frame);

            if (height != orgHeight) {
                CGSize changeSize = CGSizeMake(
                                               CGRectGetWidth(self.frame),
                                               self.contentTextBottomConstraint.constant+self.contentTextTopConstraint.constant+height
                                               );
                [self.bmInputTextViewDelegate didBMInputTextView:self changeSize:changeSize];
                
            }
            
        }
    }
}

@end
