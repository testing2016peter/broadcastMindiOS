//
//  testViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/22/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "testViewController.h"
#import "BMInputTextView.h"

#import "BMConstraintUtil.h"
@interface testViewController () <BMInputTextViewDelegate>
@property (weak, nonatomic) IBOutlet BMInputTextView *textContainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textInputViewHeightConstraint;

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textContainView.bmInputTextViewDelegate = self;
    
    //[BMConstraintUtil addAllZeroConstraintWithParentView:self.textContainView targetView:bmInputTextView];

}

- (void)didBMInputTextView:(BMInputTextView *)bmInputTextView changeSize:(CGSize )size
{
    self.textInputViewHeightConstraint.constant = size.height;
}

@end
