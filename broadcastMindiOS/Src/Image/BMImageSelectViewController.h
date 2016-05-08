//
//  BMImageSelectViewController.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/7/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMCameraRollLib.h"

@class BMImageSelectViewController;

@protocol BMImageSelectViewControllerDelegate <NSObject>
- (void)BMImageSelectViewController:(BMImageSelectViewController *)bmImageSelectViewController selectedCameraRollImageObjects:(NSArray *)selectedCameraRollImageObjects;
- (void)tapCancelWithBMImageSelectViewController:(BMImageSelectViewController *)bmImageSelectViewController;
@end

@interface BMImageSelectViewController : BMBaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id <BMImageSelectViewControllerDelegate> bmImageSelectViewControllerDelegate;
@end
