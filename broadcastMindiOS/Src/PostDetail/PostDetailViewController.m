//
//  PostDetailViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/27/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "PostDetailViewController.h"
#import "BMPostCommentCollectionViewCell.h"
#import "BMPostCollectionViewCell.h"

typedef NS_ENUM(NSUInteger, PostDetailViewControllerSection) {
    PostDetailViewControllerPostSection = 0,
    PostDetailViewControllerCommentSection = 1,
    PostDetailViewControllerSectionTotal
};

@interface PostDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PostDetailViewController
- (void)setupView
{
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:BMPostCollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:BMPostCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:BMPostCommentCollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:BMPostCommentCollectionViewCellIdentifier];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return PostDetailViewControllerSectionTotal;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == PostDetailViewControllerPostSection) {
        count = 1;
    } else {
        count = 10;
    }
    return  count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *returnCell;
    if (indexPath.section == PostDetailViewControllerPostSection) {
        BMPostCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:BMPostCollectionViewCellIdentifier forIndexPath:indexPath];

        cell.titleLabel.text = @"XXXXXX";
        cell.userNameLabel.text = @"匿名";//Translate
        cell.dateLabel.text = @"2012/12/12";
        cell.contentTextView.text = @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAABB";
         cell.borderHidden = NO;
        returnCell = cell;
    } else {
        BMPostCommentCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:BMPostCommentCollectionViewCellIdentifier forIndexPath:indexPath];
        cell.commentTextView.text  = @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAABB";
        cell.borderHidden = NO;
        returnCell = cell;


    }
    return returnCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.section == PostDetailViewControllerPostSection) {
        size = [[APNibSizeCalculator sharedInstance] sizeForNibNamed:BMPostCollectionViewCellIdentifier withstyle:APNibFixedHeightScaling];
            BMPostCollectionViewCell  *cell = [[[NSBundle bundleForClass:self.class] loadNibNamed:BMPostCommentCollectionViewCellIdentifier owner:self options:nil] lastObject];

        //size.width -= (2* 16.0f);
        size = [cell sizeForWidth:size.width text:@"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAA1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890AAABB"];
    } else {

    size = [[APNibSizeCalculator sharedInstance] sizeForNibNamed:BMPostCommentCollectionViewCellIdentifier withstyle:APNibFixedHeightScaling];
    BMPostCommentCollectionViewCell  *cell = [[[NSBundle bundleForClass:self.class] loadNibNamed:BMPostCommentCollectionViewCellIdentifier owner:self options:nil] lastObject];
    //size.width -= (2* 16.0f);
    size = [cell sizeForWidth:size.width text:@"123456789012345678901234567890123456789012345678901234567890AAABB"];
    }
    return size;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}



@end
