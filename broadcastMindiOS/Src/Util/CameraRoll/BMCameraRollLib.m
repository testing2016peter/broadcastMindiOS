//
//  EACameraRollLib.m
//  ECAuctionApp
//
//  Created by Anson Ng on 11/3/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "BMCameraRollLib.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@implementation BMCameraRollLib

+ (BOOL)isCameraAuthorizated
{
    BOOL result = NO;
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized) {
        result = YES;
    }
    return result;
}

+ (void)requestCameraAuthorizatedWithBlock:(void(^)(BOOL isCameraAuthorizated))complectedBlock
{

    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        complectedBlock(granted);
    }];
}

+ (BOOL)isCameraRollAuthorizated
{
    BOOL result = NO;
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        result = YES;
    }
    return result;
}

+ (void)requestCameraRollAuthorizatedWithBlock:(void(^)(BOOL isCameraRollAuthorizated))complectedBlock
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL isCameraRollAuthorizated = NO;
        if (status == PHAuthorizationStatusAuthorized) {
            isCameraRollAuthorizated = YES;
        }
        complectedBlock(isCameraRollAuthorizated);
    }];
}

+ (CameraRollImageObjectList *)getCameraRollImageObjectList
{
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"mediaType" ascending:NO]];
    allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType != %d",PHAssetMediaTypeVideo];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    CameraRollImageObjectList *cameraRollImageObjectList = [[CameraRollImageObjectList alloc] initWithObject:allPhotos];
    return cameraRollImageObjectList;
}

+ (void)writeImage:(UIImage *)image complectedBlock:(void(^)(BOOL success, NSError *error))complectedBlock
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError *error) {
        complectedBlock(success, error);
    }];
}

+ (void)imageWithLocalIdentifier:(NSString *)localIdentifier useOriginalSize:(BOOL)useOrginalSize complectedBlock:(void(^)(UIImage *image))complectedBlock
{

    PHAsset *asset = [[PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil] firstObject];

    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    options.networkAccessAllowed = YES;
    if (!asset) {
        //for no this asset
        complectedBlock(nil);
    }
    if (useOrginalSize) {
        options.synchronous = NO;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            if (imageData) {
                UIImage *result = [UIImage imageWithData:imageData];
                complectedBlock(result);
            } else {
                complectedBlock(nil);
            }
        }];
    } else {
        options.synchronous = YES;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        CGSize size = CGSizeMake(300.f, 300.f);
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:size
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:options
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    if (result) {
                                                        complectedBlock(result);
                                                    } else {
                                                        complectedBlock(nil);
                                                    }
                                                }];
        //PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];

    }

}

@end

@interface CameraRollImageObjectList ()

@property (strong, nonatomic) id object;

@end


@implementation CameraRollImageObjectList
- (instancetype) initWithObject:(id)object;
{
    self = [super init];
    self.object = object;
    return self;
}

- (NSInteger)count
{
    _count = 0;
    if ([self.object respondsToSelector:@selector(count)]) {
        _count = [self.object count];
    }
    return _count;
}


- (CameraRollImageObject *)cameraImageObjectWithIndex:(NSInteger)index
{
    CameraRollImageObject *cameraRollImageObject = [[CameraRollImageObject alloc]init];
    cameraRollImageObject.localIdentifier = [[self.object objectAtIndex:index] localIdentifier];
    [BMCameraRollLib imageWithLocalIdentifier:cameraRollImageObject.localIdentifier useOriginalSize:NO complectedBlock:^(UIImage *image) {
        cameraRollImageObject.thumbnailImage = image;
    }];
    return cameraRollImageObject;
}
@end

@implementation CameraRollImageObject



@end
