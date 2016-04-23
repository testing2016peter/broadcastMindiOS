//
//  EACopyableLabel.m
//  ECAuctionApp
//
//  Created by Cheng-Yuan Wu on 10/7/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "BMCopyableLabel.h"

@interface BMCopyableLabel()<UITextViewDelegate>

@end

@implementation BMCopyableLabel

/*
Make the text view function like a UILabel with user interaction and copy, select function
*/

- (id)init
{
    self = [super init];
    [self initalSetting];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initalSetting];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initalSetting];
}

- (void)initalSetting
{
    self.delegate = self;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0.0f;
    self.scrollEnabled = NO;
    self.editable = NO;
    self.selectable = YES;
    self.retainStyle = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMenuWillHideNotification:) name:UIMenuControllerWillHideMenuNotification object:nil];
}



/*
 Notice: both of these two function would trigger:
 uitextView -setText()
 uitextView -setAttributedText()
*/
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (self.retainStyle && [self.text length]) {//self.text is nil from xib
        NSMutableAttributedString *newAttributedText = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
        NSDictionary *oldAttributes = [[super attributedText] attributesAtIndex:0 effectiveRange:NULL];
        [newAttributedText addAttributes:oldAttributes range:NSMakeRange(0, attributedText.length)];
        [super setAttributedText:[newAttributedText copy]];
    } else {
        [super setAttributedText:attributedText];
    }
}

-(void)handleMenuWillHideNotification:(id)sender
{
    [[UIMenuController sharedMenuController] setMenuItems:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

@end
