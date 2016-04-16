//
//  EAPlaceholderTextView.h
//  ECAuctionApp
//
//  Created by Jeff Lin on 8/12/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMPlaceholderTextView : UITextView
@property (strong ,nonatomic) NSString *placeholderString;
@property (assign ,nonatomic) NSTextAlignment placeholderAligment;
@property (strong ,nonatomic) UIColor *placeholderColor;
@property (assign ,nonatomic) BOOL showAtFocus;
//Todo: remove these two function, should not allow public access the placeholder layer
- (void)hidePlaceholder;
- (void)showPlaceholder;

@end
