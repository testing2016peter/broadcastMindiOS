//
//  BMMenuViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/30/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMMenuViewController.h"
#import "BMMenuUserCollectionViewCell.h"
#import "BMMenuTextCollectionViewCell.h"
#import "BMAccountManager.h"
#import "BMUserPostsViewController.h"
#import "BMSettingViewController.h"
#import "UIImageView+WebCache.h"

typedef NS_ENUM(NSUInteger, BMMenuViewControllerCells) {
    BMMenuViewControllerUserCell = 0,
    BMMenuViewControllerSetting,
    BMMenuViewControllerLogout,
    BMMenuViewControllerCellsTotal,

};

@interface BMMenuViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BMMenuViewController

- (void)setupView
{
    [self setupCollectionView];
    [self.collectionView reloadData];
}

- (void)setupCollectionView
{
    [self.collectionView registerNib: [UINib nibWithNibName:BMMenuUserCollectionViewCellIdentifier bundle:nil]forCellWithReuseIdentifier:BMMenuUserCollectionViewCellIdentifier];

    [self.collectionView registerNib: [UINib nibWithNibName:BMMenuTextCollectionViewCellIdentifier bundle:nil]forCellWithReuseIdentifier:BMMenuTextCollectionViewCellIdentifier];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return BMMenuViewControllerCellsTotal;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifierWithIndexPath:indexPath] forIndexPath:indexPath];
    if (indexPath.item == BMMenuViewControllerUserCell) {
        BMMenuUserCollectionViewCell *bmMenuUserCollectionViewCell = (BMMenuUserCollectionViewCell *)cell;
        BMUser *user = [[BMAccountManager sharedInstance] currentUser];
        if (user) {
            [ bmMenuUserCollectionViewCell.userImageView sd_setImageWithURL:[NSURL URLWithString:[user profileImg] ]
                                                           placeholderImage:nil
                                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                                      if (image) {
                                                                          bmMenuUserCollectionViewCell.userImageView.image = image;
                                                                      }
                                                                  }];

            bmMenuUserCollectionViewCell.userNameLabel.text = [user dispalyName];
        } else {
            bmMenuUserCollectionViewCell.userNameLabel.text = @"Login";
        }

    } else if (indexPath.item == BMMenuViewControllerSetting) {
        BMMenuTextCollectionViewCell *bmMenuTextCollectionViewCell = (BMMenuTextCollectionViewCell *)cell;
        bmMenuTextCollectionViewCell.inputLabel.text = @"Setting";
    } else if (indexPath.item == BMMenuViewControllerLogout) {
        BMMenuTextCollectionViewCell *bmMenuTextCollectionViewCell = (BMMenuTextCollectionViewCell *)cell;
        bmMenuTextCollectionViewCell.inputLabel.text = @"Logout";

    }

    return cell;
}

- (NSString *)cellIdentifierWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    if (indexPath.item == BMMenuViewControllerUserCell) {
        identifier = BMMenuUserCollectionViewCellIdentifier;

    } else if (indexPath.item == BMMenuViewControllerSetting) {
        identifier = BMMenuTextCollectionViewCellIdentifier;

    } else if (indexPath.item == BMMenuViewControllerLogout) {
        identifier = BMMenuTextCollectionViewCellIdentifier;

    } else {
        identifier = BMMenuTextCollectionViewCellIdentifier;
    }

    return identifier;
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:[self cellIdentifierWithIndexPath:indexPath] withstyle:APNibFixedHeightScaling];
    size.width = self.collectionView.frame.size.width;
    BMUser *user = [[BMAccountManager sharedInstance] currentUser];
    if (indexPath.item == BMMenuViewControllerLogout && !user) {
        size.height = 0.0f;
    }


    return size;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.item == BMMenuViewControllerUserCell) {
        if (![[BMAccountManager sharedInstance] currentUser]) {
            [[BMAccountManager sharedInstance] requestLoginWithParentViewController:self];
        } else {
            BMUserPostsViewController *vc = [[BMUserPostsViewController alloc] init];
            if (self.parentViewController && self.parentViewController.navigationController) {
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
            }

        }
    } else if (indexPath.item == BMMenuViewControllerSetting) {
        BMSettingViewController *settingVc = [[BMSettingViewController alloc] init];

        if (self.parentViewController && self.parentViewController.navigationController) {
            [self.parentViewController.navigationController pushViewController:settingVc animated:YES];
        }

    } else if (indexPath.item == BMMenuViewControllerLogout && [[BMAccountManager sharedInstance] currentUser]) {
        [[BMAccountManager sharedInstance] logout];
    }

}

- (void)setupNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleLogin:) name:BMAccountManagerUserLoginSuccessNotification object:nil];
    [nc addObserver:self selector:@selector(handleLogout:) name:BMAccountManagerUserLoginFailNotification object:nil];

}

- (void)handleLogin:(id)test
{
    [self.collectionView reloadData];
    
}

- (void)handleLogout:(id)test
{
    
    [self.collectionView reloadData];
}
@end
