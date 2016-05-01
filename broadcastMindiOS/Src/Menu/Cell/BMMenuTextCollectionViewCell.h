//
//  BMMenuLogoutCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseCollectionViewCell.h"
static NSString * const BMMenuTextCollectionViewCellIdentifier = @"BMMenuTextCollectionViewCell";

@interface BMMenuTextCollectionViewCell : BMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;

@end
