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
    return size;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
