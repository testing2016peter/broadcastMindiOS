//
//  BMMainFilterView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseView.h"
IB_DESIGNABLE
@interface BMMainFilterView : BMBaseView

@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *articleNewButton;
@property (weak, nonatomic) IBOutlet UIButton *articleHostestButton;
@property (weak, nonatomic) IBOutlet UIView *topLevelSubview;

@end
