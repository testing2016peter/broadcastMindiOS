//
//  EAPlaceholderTextView.m
//  ECAuctionApp
//
//  Created by Jeff Lin on 8/12/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "BMPlaceholderTextView.h"

@interface BMPlaceholderTextView ()
@property (strong, nonatomic) CATextLayer *placeholderLayer;

@end

@implementation BMPlaceholderTextView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupNotification];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNotification];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupNotification];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark - setter/getter
- (void)setPlaceholderString:(NSString *)placeholderString
{
    _placeholderString = placeholderString;
    if (_placeholderString.length) {
        self.placeholderLayer.string = _placeholderString;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLayer.foregroundColor = _placeholderColor.CGColor;
    self.placeholderLayer.alignmentMode = kCAAlignmentRight;
}

- (void)setPlaceholderAligment:(NSTextAlignment)placeholderAligment
{
    _placeholderAligment = placeholderAligment;
    if (NSTextAlignmentLeft == placeholderAligment) {
        self.placeholderLayer.alignmentMode = kCAAlignmentLeft;
    }
    else if (NSTextAlignmentRight == placeholderAligment) {
        self.placeholderLayer.alignmentMode = kCAAlignmentRight;
    }
    else if (NSTextAlignmentCenter == placeholderAligment) {
        self.placeholderLayer.alignmentMode = kCAAlignmentCenter;
    }
}

- (CATextLayer *)placeholderLayer
{
    if (!_placeholderLayer) {
        _placeholderLayer = ({
            CGRect cursorRect = [self caretRectForPosition:self.selectedTextRange.start];
            CATextLayer *textLayer = [CATextLayer layer];
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            textLayer.fontSize = self.font.pointSize;
            textLayer.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(cursorRect.origin.y, cursorRect.origin.x, cursorRect.origin.y, cursorRect.origin.x));
            textLayer;
        });
        [self.layer addSublayer:_placeholderLayer];
    }
    return _placeholderLayer;
}

#pragma mark - notification
- (void)textDidBeginEditing:(NSNotification *)notification
{
    if (!_showAtFocus) {
        self.placeholderLayer.hidden = YES;
    }
}

- (void)textDidChange:(NSNotification *)notification
{
    if (self.text.length > 0) {
        self.placeholderLayer.hidden = YES;
    }else {
        self.placeholderLayer.hidden = NO;
    }
}

- (void)textDidEndEditing:(NSNotification *)notification
{
    self.placeholderLayer.hidden = [self hasText];
}

- (void)hidePlaceholder
{
    self.placeholderLayer.hidden = YES;
}

- (void)showPlaceholder
{
    self.placeholderLayer.hidden = NO;
}

@end
