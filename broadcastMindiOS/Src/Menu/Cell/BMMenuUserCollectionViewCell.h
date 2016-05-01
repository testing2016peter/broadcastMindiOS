//
//  BMMenuUserCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseCollectionViewCell.h"
static NSString * const BMMenuUserCollectionViewCellIdentifier = @"BMMenuUserCollectionViewCell";
@interface BMMenuUserCollectionViewCell : BMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
