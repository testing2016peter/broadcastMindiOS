//
//  BMArticleListViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/16/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "TLYShyNavBarManager.h"
#import "BMPostListViewController.h"
#import "BMInputTextView.h"
#import "BMPostCollectionViewCell.h"
#import "BMCommonViewUtil.h"
#import "BMInsertPostViewController.h"
#import "BMPostListDataStore.h"
#import "BMMainFilterView.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "BMUserPostsViewController.h"
#import "PostDetailViewController.h"
#import "BMSettingViewController.h"
#import "BMMenuViewController.h"
#import "BMCacheManager.h"
#import "BMAccountManager.h"
#import "UITextView+BMTextView.h"
#import "BMStringParser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BMPostListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, BMPostArticleViewControllerDelegate, UITextViewDelegate>
@property (strong, nonatomic) BMPostListDataStore *dataStore;
@property (strong, nonatomic) NSMutableArray *bmArticles;
@property (strong, nonatomic) TLYShyNavBarManager *shyManage;
@property (strong, nonatomic) BMMainFilterView *bmMainFilterView;
@property (strong, nonatomic) BMMenuViewController *bmMenuViewController;
@property (assign, nonatomic) CGFloat bmMenuViewControllerViewWidth;
@property (assign, nonatomic) BOOL isShowedMenu;
@end

@implementation BMPostListViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupMenuFrameOnce];

    UIButton *button = [BMCommonViewUtil floatingButtonWithView:self.view image:[UIImage imageNamed:@"Icon-Plus"] backgroundImage:[UIImage imageNamed:@"Icon-Plus"] alpha:1.0f target:self action:@selector(tapPostButton:)];
    [self.view addSubview:button];
    CGRect rect = self.view.bounds;
    rect.size.height = 30.0f;
    self.bmMainFilterView = [[BMMainFilterView alloc] initWithFrame:rect];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    searchBar.barTintColor = [UIColor BMBackgroundColor];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = searchBar;
}

- (void)setupMenuFrameOnce
{
    static dispatch_once_t onceToken;


    dispatch_once(&onceToken, ^{
        self.bmMenuViewController.view.frame = CGRectMake(CGRectGetMaxX(self.view.frame),
                                                          CGRectGetMaxY(self.navigationController.navigationBar.frame),
                                                          self.bmMenuViewControllerViewWidth,
                                                          CGRectGetHeight(self.view.frame)
                                                          );
    });



}

- (void)setupView
{
    //    UIImage *image = [UIImage imageNamed:@"Img-test-image"];
    //    NSProgress *progress = [[NSProgress alloc] init];
    //    [[BMService sharedInstance] uploadImage:image progress:&progress success:^(AFHTTPRequestOperation *operation, id response) {
    //        NSLog(@"success:%@", response);
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
    //        NSLog(@"err:%@", err);
    //    }];
    //    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];

    self.bmMenuViewControllerViewWidth = 250.0f;

    [self.navigationController.navigationBar setTranslucent:NO];

    self.bmMenuViewController = [[BMMenuViewController alloc] init];
    self.bmMenuViewController.view.frame = CGRectMake(CGRectGetMaxX(self.view.frame),
                                                      CGRectGetHeight(self.navigationController.navigationBar.frame),
                                                      self.bmMenuViewControllerViewWidth,
                                                      CGRectGetHeight(self.view.frame)
                                                      );

    [self.view addSubview:self.bmMenuViewController.view];
    [self addChildViewController:self.bmMenuViewController];

    UIImage *closeButtonImage = [UIImage imageNamed:@"Icon-User-White"];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:closeButtonImage forState:UIControlStateNormal];
    closeButton.bounds = CGRectMake(0.0f, 0.0f, 30, 30);
    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [closeButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];

    TLYShyNavBarManager *shyManager = [[TLYShyNavBarManager alloc] init];
    self.shyNavBarManager = shyManager;
    self.shyNavBarManager.scrollView = self.collectionView;

    self.bmArticles = [NSMutableArray array];
    self.dataStore = [[BMPostListDataStore alloc] init];
    [self setupCollectionView];
    [self.dataStore beginWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        self.bmArticles = [self.dataStore.data copy];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
    }];

}


- (void)setupCollectionView
{
    [[BMService sharedInstance] loginUserEmail:@"cwnga@yahoo-inc.com" password:@"12345" success:^(AFHTTPRequestOperation *operation, id response) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
    }];
    [self.collectionView registerNib: [UINib nibWithNibName:BMPostCollectionViewCellIdentifier bundle:nil]forCellWithReuseIdentifier:BMPostCollectionViewCellIdentifier];

    [self.collectionView addPullToRefreshWithActionHandler:^{
        [self.collectionView.pullToRefreshView stopAnimating];

    }];
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [self.dataStore loadNextBunchWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
            [self.collectionView.infiniteScrollingView stopAnimating];
            self.bmArticles = [self.dataStore.data copy];
            [self.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        }];
        [self.collectionView.infiniteScrollingView stopAnimating];
    }];
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

        cell.userNameLabel.text = @"匿名";//Translate
        cell.dateLabel.text = article.updatedAt;

        NSString *string = article.text;
        cell.titleLabel.text = string;
        NSRange range = [BMStringParser nonImageURLStringRangeWithString:string];
        NSString *subString = [string substringWithRange:range];

        NSArray *imageUrls = [BMStringParser imageURLStringsRangeWithString:string];
        if ([imageUrls count] > 0) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[imageUrls firstObject]]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         if (image && !error) {
                                             cell.imageView.image = image;
                                             cell.imageViewHeightConstraint.constant = 200.0f;
                                         }
                                     }];
        }
        cell.contentTextView.text = subString;
        cell.contentTextView.delegate = self;
        cell.contentTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    }


    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:BMPostCollectionViewCellIdentifier withstyle:APNibFixedHeightScaling];
    BMPostCollectionViewCell  *cell = [[[NSBundle bundleForClass:self.class] loadNibNamed:BMPostCollectionViewCellIdentifier owner:self options:nil] lastObject];
    //size.width -= (2* 16.0f);
    BMPost *article = self.bmArticles[indexPath.item];
    NSString *string = article.text;
    NSRange range = [BMStringParser nonImageURLStringRangeWithString:string];
    NSString *subString = [string substringWithRange:range];
    BOOL hasImage = NO;
    if ([[BMStringParser imageURLStringsRangeWithString:string] count] > 0) {
        hasImage = YES;
    }
    size = [cell sizeForWidth:size.width text:subString hasImage:hasImage];
    return size;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //
    //    BMSettingViewController *postDetailViewController = [[BMSettingViewController alloc] init];
    //    [self.navigationController pushViewController:postDetailViewController animated:YES];
}

- (void)tapPostButton:(UIButton *)button
{
    BMInsertPostViewController *vc = [[BMInsertPostViewController alloc] init];
    vc.view.frame = self.view.bounds;
    vc.postArticleViewControllerDelegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
}

-(void)tapPostArticleViewController:(BMInsertPostViewController *)vc cancelButton:(id)cancelButton
{
    [vc.view removeFromSuperview];
}

-(void)tapPostArticleViewController:(BMInsertPostViewController *)vc contentText:(NSString *)contentText sendButton:(id)sendButton
{
    [[BMService sharedInstance] insertPostWithText:contentText success:^(AFHTTPRequestOperation *operation, id response) {
        [vc.view removeFromSuperview];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [vc.view removeFromSuperview];
    }];

}

- (void)showMenu:(id)sender
{
    [self showHideoMenu];
}

- (void)showHideoMenu
{
    static BOOL isShowing;
    if (isShowing == NO) {
        [UIView animateWithDuration:0.5f animations:^{
            isShowing = YES;
            if (self.isShowedMenu == YES) {
                //hide menu
                self.collectionView.userInteractionEnabled = YES;
                self.collectionView.frame = CGRectMake(
                                                       0.0f,
                                                       CGRectGetMinY(self.collectionView.frame),
                                                       CGRectGetWidth(self.collectionView.frame),
                                                       CGRectGetHeight(self.collectionView.frame)
                                                       );
                self.bmMenuViewController.view.frame = CGRectMake(
                                                                  CGRectGetMaxX(self.collectionView.frame),
                                                                  CGRectGetMinY(self.bmMenuViewController.view.frame),
                                                                  CGRectGetWidth(self.bmMenuViewController.view.frame),
                                                                  CGRectGetHeight(self.bmMenuViewController.view.frame)
                                                                  );
            } else {
                //show menu

                self.collectionView.userInteractionEnabled = NO;
                self.collectionView.frame = CGRectMake(
                                                       - CGRectGetWidth(self.bmMenuViewController.view.frame),
                                                       CGRectGetMinY(self.collectionView.frame),
                                                       CGRectGetWidth(self.collectionView.frame),
                                                       CGRectGetHeight(self.collectionView.frame)
                                                       );
                self.bmMenuViewController.view.frame = CGRectMake(
                                                                  CGRectGetMinX(self.bmMenuViewController.view.frame) - CGRectGetWidth(self.bmMenuViewController.view.frame),
                                                                  CGRectGetMinY(self.bmMenuViewController.view.frame),
                                                                  CGRectGetWidth(self.bmMenuViewController.view.frame),
                                                                  CGRectGetHeight(self.bmMenuViewController.view.frame)
                                                                  );

            }

        } completion:^(BOOL finished) {
            isShowing = NO;
            self.isShowedMenu = !self.isShowedMenu;
        }];
    }
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSString *urlString = [URL absoluteString];
    return YES;
    
    //    return NO;
}

@end
