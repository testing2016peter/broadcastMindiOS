//
//  BMMyViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/23/16.
//  Copyright © 2016 ap. All rights reserved.
//
#import "BMSettingViewController.h"
#import "BMInputFieldCollectionViewCell.h"
#import "BMInputSwitchCollectionViewCell.h"
#import "BMSettingHeaderReusableView.h"
#import "BMInputTextView.h"
#import "BMPostCollectionViewCell.h"
#import "BMCommonViewUtil.h"
#import "BMService.h"

@interface BMSettingViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIImageView *userBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *userImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;

@end

@implementation BMSettingViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupView
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setupCollectionView];
    [self.collectionView reloadData];
}

- (NSArray *)config
{
    static NSArray *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = @[
                   @{
                       @"header":@{@"name":@"User Profile"},
                       @"cells":@[@{
                                      @"id":@"nickName",
                                      @"name":@"Nick Name",
                                      @"cellIdentifier": BMInputFieldCollectionViewCellIndentifier,
                                      @"selectorName": @"setupNickNameWithCell:"
                                      }
                                  ],
                       },
                   @{@"header":@{@"name":@"Notification"
                                 },
                     @"cells":@[
                             @{
                                 @"id":@"notification",
                                 @"name":@"enable",
                                 @"cellIdentifier": BMInputSwitchCollectionViewCellIndentifier,
                                 @"selectorName": @"setupNotificationWithCell:"

                                 }
                             ],
                     }
                   ];
    });
    return config;
}
- (void)setupCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:BMSettingHeaderReusableViewIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BMSettingHeaderReusableViewIdentifier];
    [self.collectionView registerNib: [UINib nibWithNibName:BMInputFieldCollectionViewCellIndentifier bundle:nil]forCellWithReuseIdentifier:BMInputFieldCollectionViewCellIndentifier];
    [self.collectionView registerNib: [UINib nibWithNibName:BMInputSwitchCollectionViewCellIndentifier bundle:nil]forCellWithReuseIdentifier:BMInputSwitchCollectionViewCellIndentifier];
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
    return [[self config] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = [self config][section][@"cells"];
    return [array count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    NSDictionary *rowSetting = [self cellConfig:indexPath];
    NSString *cellIdentifier = rowSetting[@"cellIdentifier"];
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[BMInputFieldCollectionViewCell class]]) {
        BMInputFieldCollectionViewCell *bmInputFieldCollectionViewCell = (BMInputFieldCollectionViewCell *)cell;

        bmInputFieldCollectionViewCell.inputLabel.text = rowSetting[@"name"];


    } else if ([cell isKindOfClass:[BMInputSwitchCollectionViewCell class]]) {
        BMInputSwitchCollectionViewCell *bmInputSwitchCollectionViewCell = (BMInputSwitchCollectionViewCell *)cell;

    }

    SEL theSelector = NSSelectorFromString(rowSetting[@"selectorName"]);
    if ([self respondsToSelector:theSelector]) {
        NSInvocation *anInvocation = [NSInvocation
                                      invocationWithMethodSignature:
                                      [[BMSettingViewController class] instanceMethodSignatureForSelector:theSelector]];

        [anInvocation setSelector:theSelector];
        [anInvocation setTarget:self];

        [anInvocation setArgument:&cell atIndex:2];

        [anInvocation performSelector:@selector(invoke) withObject:nil afterDelay:0];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *rowSetting = [self cellConfig:indexPath];
    NSString *cellIdentifier = rowSetting[@"cellIdentifier"];
   CGSize size =  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:cellIdentifier withstyle:APNibFixedHeightScaling];
    return size;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
    return UIEdgeInsetsMake(CGRectGetHeight(self.userView.frame)+10.0f, 0.0f, 0.0f, 0.0f);
    }
    return UIEdgeInsetsZero;
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

- (NSDictionary *)cellConfig:(NSIndexPath *)indexPath
{
    NSArray *config = [self config];

    NSDictionary *rowSetting = config[indexPath.section][@"cells"][indexPath.item];
    return rowSetting;

}
#pragma mark - setup Cell
- (void)setupNickNameWithCell:(BMInputFieldCollectionViewCell *)cell
{
    cell.inputTextField.text = @"";
}
- (void)setupNotificationWithCell:(BMInputSwitchCollectionViewCell *)cell
{
    cell.inputSwitch.on = YES;
}
@end
