//
//  BMControlCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseCollectionViewCell.h"

static NSString * const BMInputSwitchCollectionViewCellIndentifier = @"BMInputSwitchCollectionViewCell";
@interface BMInputSwitchCollectionViewCell : BMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *inputSwitch;

@end
