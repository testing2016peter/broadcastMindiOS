//
//  BMInputTextView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPlaceholderTextView.h"
@interface BMInputTextView : UIView

@property (weak, nonatomic) IBOutlet BMPlaceholderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
