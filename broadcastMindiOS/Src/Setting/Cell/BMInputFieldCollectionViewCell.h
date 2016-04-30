//
//  BMInputFieldCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseCollectionViewCell.h"
static NSString * const BMInputFieldCollectionViewCellIndentifier = @"BMInputFieldCollectionViewCell";
@interface BMInputFieldCollectionViewCell : BMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end
