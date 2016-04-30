//
//  BMSettingHeaderReusableView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const BMSettingHeaderReusableViewIdentifier = @"BMSettingHeaderReusableView";
@interface BMSettingHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end
