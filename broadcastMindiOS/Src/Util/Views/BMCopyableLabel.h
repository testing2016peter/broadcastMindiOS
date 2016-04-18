//
//  EACopyableLabel.h
//  ECAuctionApp
//
//  Created by Cheng-Yuan Wu on 10/7/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BMCopyableLabel : UITextView

@property (nonatomic, assign) BOOL retainStyle; // retain xib attribute text style, default is YES

@end
