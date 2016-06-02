//
//  BMTabBarController.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 6/2/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMTabBarController : UITabBarController

@property (assign, nonatomic) NSUInteger currentSelectedIndex;
@property (assign, nonatomic) NSUInteger previousSelectedIndex;
@property (assign, nonatomic) NSUInteger intendedSelectedIndex;

@end
