//
//  BMInputTextView.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInputTextView.h"
@interface BMInputTextView () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topLevelSubview;
@end
@implementation BMInputTextView


- (instancetype)init
{
    return [self initWithFrame:self.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFromNibWithRect:self.bounds];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadFromNibWithRect:self.bounds];
    }

    return self;
}

- (void)loadFromNibWithRect:(CGRect)rect
{
    [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    self.topLevelSubview.frame = rect;
    [self addSubview:self.topLevelSubview];
    [self setupView];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupView];
}
- (void)setupView
{
}
@end
