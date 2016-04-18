//
//  BMArticleListViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/16/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <TLYShyNavBarManager.h>
#import "BMArticleListViewController.h"
#import "BMInputTextView.h"
#import "BMArticleListCollectionViewCell.h"
#import "BMCommonViewUtil.h"
#import "BMPostArticleViewController.h"
#import "BMArticleListDataStore.h"
#import "BMMainFilterCollectionReusableView.h"
#import "BMMainFilterView.h"
#import "UIColor+BMColor.h"
@interface BMArticleListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, BMPostArticleViewControllerDelegate>
@property (strong, nonatomic) BMArticleListDataStore *dataStore;
@property (strong, nonatomic) NSMutableArray *bmArticles;
@property (strong, nonatomic) TLYShyNavBarManager *shyManage;
@property (strong, nonatomic) BMMainFilterView *bmMainFilterView;

@end

@implementation BMArticleListViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIButton *button = [BMCommonViewUtil floatingButtonWithView:self.view image:[UIImage imageNamed:@"Icon-Plus"] backgroundImage:[UIImage imageNamed:@"Icon-Plus"] alpha:1.0f target:self action:@selector(tapPostButton:)];
    [self.view addSubview:button];
    CGRect rect = self.view.bounds;
    rect.size.height = 30.0f;
    self.bmMainFilterView = [[BMMainFilterView alloc] initWithFrame:rect];
    [self.shyNavBarManager setExtensionView:self.bmMainFilterView];
    /* Make navbar stick to the top */
    [self.shyNavBarManager setStickyNavigationBar:NO];
    /* Make the extension view stick to the top */
    [self.shyNavBarManager setStickyExtensionView:NO];


    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    searchBar.barTintColor = [UIColor BMBackgroundColor];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = searchBar;

}


- (void)setupView
{

    TLYShyNavBarManager *shyManager = [[TLYShyNavBarManager alloc] init];
    self.shyNavBarManager = shyManager;
    self.shyNavBarManager.scrollView = self.collectionView;

    self.bmArticles = [NSMutableArray array];
    self.dataStore = [[BMArticleListDataStore alloc] init];
    [self setupCollectionView];
    [self.dataStore beginWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"respons:%@" ,response);
        self.bmArticles = [self.dataStore.data copy];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"respons:%@" ,err);
    }];


}

- (void)setupCollectionView
{
    [[BMService sharedInstance] loginUserEmail:@"cwnga@yahoo-inc.com" password:@"12345" success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"success:%@,", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"err:%@,", err);
    }];
    [self.collectionView registerNib: [UINib nibWithNibName:BMArticleListCollectionViewCellIdentified bundle:nil]forCellWithReuseIdentifier:BMArticleListCollectionViewCellIdentified];
    [self.collectionView registerNib: [UINib nibWithNibName:BMMainFilterCollectionReusableViewIdentified bundle:nil]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BMMainFilterCollectionReusableViewIdentified];
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
    BMArticleListCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:BMArticleListCollectionViewCellIdentified forIndexPath:indexPath];
    if (indexPath.item < self.bmArticles.count) {
        BMArticle *article = self.bmArticles[indexPath.item];
        cell.contentTextView.text = article.text;
        cell.userNameLabel.text = @"匿名";//Translate
        cell.dateLabel.text = article.updatedAt;
    }
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
- (void)tapPostButton:(UIButton *)button
{
    BMPostArticleViewController *vc = [[BMPostArticleViewController alloc] init];
    vc.view.frame = self.view.bounds;
    vc.postArticleViewControllerDelegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];

}

-(void)tapPostArticleViewController:(BMPostArticleViewController *)vc cancelButton:(id)cancelButton
{
    [vc.view removeFromSuperview];
}

-(void)tapPostArticleViewController:(BMPostArticleViewController *)vc sendButton:(id)sendButton
{
    [[BMService sharedInstance] insertArticleWithText:vc.contentTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response:%@" ,response);
        [vc.view removeFromSuperview];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"err:%@" ,err);
        [vc.view removeFromSuperview];
    }];

}



@end
