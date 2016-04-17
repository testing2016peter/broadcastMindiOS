//
//  BMArticleFunctionView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//
#import "BMBaseView.h"
IB_DESIGNABLE
@interface BMArticleFunctionView : BMBaseView
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *viewNumberLabel;

@end
