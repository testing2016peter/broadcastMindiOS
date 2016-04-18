//
//  BMMainFilterView.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseView.h"

@class BMMainFilterView;
@protocol BMMainFilterViewDelegate <NSObject>

- (IBAction)tapBMMainFilterView:(BMMainFilterView *)filterView meButton:(id)sender;
- (IBAction)tapBMMainFilterView:(BMMainFilterView *)filterView newButton:(id)sender;
- (IBAction)tapBMMainFilterView:(BMMainFilterView *)filterView hotestButton:(id)sender;

@end
IB_DESIGNABLE
@interface BMMainFilterView : BMBaseView

@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *articleNewButton;
@property (weak, nonatomic) IBOutlet UIButton *articleHostestButton;
@property (weak, nonatomic) IBOutlet UIView *topLevelSubview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleNewButtonWidthContraint;
@property (weak, nonatomic) id <BMMainFilterViewDelegate>bmMainFilterViewDelegate;
@end
