//
//  BMArticleListViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/16/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMArticleListViewController.h"
#import "BMInputTextView.h"
#import "BMArticleListCollectionViewCell.h"
@interface BMArticleListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation BMArticleListViewController

- (void)setupView
{

    [self setupCollectionView];
}

- (void)setupCollectionView
{
    [self.collectionView registerNib: [UINib nibWithNibName:BMArticleListCollectionViewCellIdentified bundle:nil]forCellWithReuseIdentifier:BMArticleListCollectionViewCellIdentified];
}






#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMArticleListCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:BMArticleListCollectionViewCellIdentified forIndexPath:indexPath];
    return cell;
}



#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:BMArticleListCollectionViewCellIdentified withstyle:APNibFixedHeightScaling];
    size.width -= (2* 16.0f);
    return size;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
