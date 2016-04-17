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
#import "BMCommonViewUtil.h"
#import "PostArticleViewController.h"

@interface BMArticleListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, PostArticleViewControllerDelegate>

@end

@implementation BMArticleListViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIButton *button = [BMCommonViewUtil floatingButtonWithView:self.view image:[UIImage imageNamed:@"Icon-Plus"] backgroundImage:[UIImage imageNamed:@"Icon-Plus"] alpha:1.0f target:self action:@selector(tapPostButton:)];
    [self.view addSubview:button];
}
- (void)setupView
{
    [self setupCollectionView];

}

- (void)setupCollectionView
{
    [[BMService sharedInstance] loginUserEmail:@"cwnga@yahoo-inc.com" password:@"12345" success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"success:%@,", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"err:%@,", err);
    }];
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
- (void)tapPostButton:(UIButton *)button
{
    PostArticleViewController *vc = [[PostArticleViewController alloc] init];
    vc.view.frame = self.view.bounds;
    vc.postArticleViewControllerDelegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];

}
-(void)tapPostArticleViewController:(PostArticleViewController *)vc cancelButton:(id)cancelButton
{

    [vc.view removeFromSuperview];
}
-(void)tapPostArticleViewController:(PostArticleViewController *)vc sendButton:(id)sendButton
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
