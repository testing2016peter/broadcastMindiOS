//
//  BMMyViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/23/16.
//  Copyright © 2016 ap. All rights reserved.
//
#import "TLYShyNavBarManager.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "BMUserPostsViewController.h"
#import "BMPostListDataStore.h"
#import "BMInputTextView.h"
#import "BMPostCollectionViewCell.h"
#import "BMCommonViewUtil.h"

@interface BMUserPostsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIImageView *userBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *userImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (strong, nonatomic) BMPostListDataStore *dataStore;
@property (strong, nonatomic) NSMutableArray *bmArticles;

@end

@implementation BMUserPostsViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.dataStore = [[BMPostListDataStore alloc] init];
    [self setupCollectionView];

    [self.dataStore beginWithSuccess:^(AFHTTPRequestOperation *operation, id response) {

        self.bmArticles = [self.dataStore.data copy];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        //TODO
    }];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];


}

- (void)setupCollectionView
{
    [self.collectionView registerNib: [UINib nibWithNibName:BMPostCollectionViewCellIdentifier bundle:nil]forCellWithReuseIdentifier:BMPostCollectionViewCellIdentifier];

    __weak __typeof(self)weakSelf = self;
    [self.collectionView addPullToRefreshWithActionHandler:^{
        [weakSelf.dataStore reloadWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
            weakSelf.userView.frame = CGRectMake(0, 0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
            [UIView animateWithDuration:0.5f animations:^{
                weakSelf.userView.frame = CGRectMake(0, 0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
            }];
            weakSelf.bmArticles = [[NSMutableArray alloc] initWithArray:self.dataStore.data];
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.pullToRefreshView stopAnimating];
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            [weakSelf.collectionView.pullToRefreshView stopAnimating];
        }];


    }];
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf.dataStore loadNextBunchWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
            [weakSelf.collectionView.infiniteScrollingView stopAnimating];
            weakSelf.bmArticles = [[NSMutableArray alloc] initWithArray:self.dataStore.data];
            [weakSelf.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        }];
        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
    }];


}

#pragma mark - tap
- (IBAction)tapBackButton:(id)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bmArticles.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMPostCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:BMPostCollectionViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.item < self.bmArticles.count) {
        BMPost *article = self.bmArticles[indexPath.item];
        cell.contentTextView.text = article.text;
        cell.userNameLabel.text = @"匿名";//Translate
        cell.dateLabel.text = article.updatedAt;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:BMPostCollectionViewCellIdentifier withstyle:APNibFixedHeightScaling];
    return size;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(CGRectGetHeight(self.userView.frame)+10.0f, 0.0f, 0.0f, 0.0f);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //TODO: fix me
    static CGFloat lastScrollViewContentOffsetY = 0;
    if (CGRectGetMinX(self.userView.frame)<=0) {
        self.userView.frame = CGRectMake(0, -lastScrollViewContentOffsetY / 2.0f, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
    } else {
        self.userView.frame = CGRectMake(0, 0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
    }
    lastScrollViewContentOffsetY = scrollView.contentOffset.y;
}

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint pointInView = [tapGestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(self.backButton.frame, pointInView)) {
        [self tapBackButton:nil];
    }
}

@end
