//
//  BMImageSelectImageCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/7/16.
//  Copyright © 2016 ap. All rights reserved.
//
#import "BMBaseCollectionViewCell.h"
static NSString * const BMImageSelectImageCollectionViewCellIdentifier = @"BMImageSelectImageCollectionViewCell";
@interface BMImageSelectImageCollectionViewCell : BMBaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
