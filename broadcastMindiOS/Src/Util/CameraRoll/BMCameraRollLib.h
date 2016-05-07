//
//  EACameraRollLib.h
//  ECAuctionApp
//
//  Created by Anson Ng on 11/3/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CameraRollImageObject;
@class CameraRollImageObjectList;

@interface BMCameraRollLib : NSObject

+ (BOOL)isCameraAuthorizated;
+ (void)requestCameraAuthorizatedWithBlock:(void(^)(BOOL isCameraAuthorizated))complectedBlock;
+ (BOOL)isCameraRollAuthorizated;
+ (void)requestCameraRollAuthorizatedWithBlock:(void(^)(BOOL isCameraRollAuthorizated))complectedBlock;

+ (CameraRollImageObjectList *)getCameraRollImageObjectList;
+ (void)writeImage:(UIImage *)image complectedBlock:(void(^)(BOOL success, NSError *error))complectedBlock;
+ (void)imageWithLocalIdentifier:(NSString *)localIdentifier useOriginalSize:(BOOL)useOrginalSize complectedBlock:(void(^)(UIImage *image))complectedBlock;

@end

@interface CameraRollImageObjectList : NSObject
@property (assign, nonatomic) NSInteger count;

- (instancetype) initWithObject:(id)object;
- (CameraRollImageObject *)cameraImageObjectWithIndex:(NSInteger)index;

@end

@interface CameraRollImageObject : NSObject

@property (strong, nonatomic) NSString *localIdentifier;
@property (strong, nonatomic) UIImage *thumbnailImage;

@end