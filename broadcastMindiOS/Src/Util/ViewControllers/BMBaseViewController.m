//
//  BMBaseViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseViewController.h"
#import "UIColor+BMColor.h"

@interface BMBaseViewController ()

@end

@implementation BMBaseViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [BMTrackUtil logEvent:BMTrackEventNameViewDidAppear withParameters:@{BMTrackParameterNameView: NSStringFromClass([self class])}];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        [self setupBaseView];
    [self setupView];
}

- (void)setupBaseView
{
    self.view.backgroundColor = [UIColor BMBackgroundColor];
}

- (void)setupView
{
}
@end
