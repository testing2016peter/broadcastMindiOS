//
//  BMImageSelectViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/7/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMImageSelectViewController.h"
#import "BMImageSelectImageCollectionViewCell.h"

@interface BMImageSelectViewController ()
@property (assign, nonatomic) CGSize imageCellSize;
@property (strong, nonatomic) CameraRollImageObjectList *cameraRollImageObjectList;
@property (strong, nonatomic) NSMutableArray *selectedObjectIndexs;
@end

@implementation BMImageSelectViewController

- (void)setupView
{

    if ([BMCameraRollLib isCameraRollAuthorizated] == NO) {
        [BMCameraRollLib requestCameraRollAuthorizatedWithBlock:^(BOOL isCameraRollAuthorizated) {
            [self setupViewAndDatas];
        }];
    } else {
        [self setupViewAndDatas];
    }
}

- (void)setupViewAndDatas
{

    self.selectedObjectIndexs = [NSMutableArray array];
    [self setupCollectionView];
    self.cameraRollImageObjectList = [BMCameraRollLib getCameraRollImageObjectList];
    [self.collectionView reloadData];
}

- (void)setupCollectionView
{
    self.collectionView.allowsMultipleSelection=YES;
    [self.collectionView registerNib:[UINib nibWithNibName:BMImageSelectImageCollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:BMImageSelectImageCollectionViewCellIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cameraRollImageObjectList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMImageSelectImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BMImageSelectImageCollectionViewCellIdentifier forIndexPath:indexPath];
    CameraRollImageObject *cameraRollImageObject = [self.cameraRollImageObjectList cameraImageObjectWithIndex:indexPath.item];
    cell.imageView.image = cameraRollImageObject.thumbnailImage;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self imageCellSize];
}

- (CGSize)imageCellSize
{
    if (_imageCellSize.width <= 0.0f) {
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        CGFloat screenWidth = screenSize.width;
        _imageCellSize = CGSizeMake(screenWidth/3, screenWidth/3);
    }
    return _imageCellSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    BMImageSelectImageCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    CameraRollImageObject *cameraRollImageObject = [self.cameraRollImageObjectList cameraImageObjectWithIndex:indexPath.item];
    [self.selectedObjectIndexs addObject:@(indexPath.item)];
    NSLog(@"%@", self.selectedObjectIndexs);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BMImageSelectImageCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = NO;
    CameraRollImageObject *cameraRollImageObject = [self.cameraRollImageObjectList cameraImageObjectWithIndex:indexPath.item];

    [self.selectedObjectIndexs removeObject:@(indexPath.item)];
    NSLog(@"%@", self.selectedObjectIndexs);

}

- (IBAction)tapConfirmButton:(id)sender
{
    NSLog(@"%@", [self selectObjecs]);

    if ([self.bmImageSelectViewControllerDelegate respondsToSelector:@selector(BMImageSelectViewController:selectedCameraRollImageObjects:)]) {

        [self.bmImageSelectViewControllerDelegate BMImageSelectViewController:self selectedCameraRollImageObjects:[self selectObjecs]];
    }
}

- (NSArray *)selectObjecs
{
    NSMutableArray *selectObjecs = [NSMutableArray array];
    [self.selectedObjectIndexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        [selectObjecs addObject:[self.cameraRollImageObjectList cameraImageObjectWithIndex:index]];
    }];
    return [selectObjecs copy];

}
- (IBAction)tapCancelButton:(id)sender
{
    if ([self.bmImageSelectViewControllerDelegate respondsToSelector:@selector(tapCancelWithBMImageSelectViewController:)]) {
        [self.bmImageSelectViewControllerDelegate tapCancelWithBMImageSelectViewController:self];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
