//
//  YDKNibCacheManager.h
//  YDevelopKit
//
//  Created by Chih Feng Sung on 6/8/15.
//  Copyright (c) 2015 Yahoo-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APKNibCacheManager : NSObject

/**
 * @brief Geting a shared instance of YDKNibCacheManager.
 *
 * @return Instance of YDKNibCacheManager.
 */
+ (instancetype)sharedInstance;

/**
 * @brief This is a method for get singleton instance from Nib file.
 *
 * @param className input class name for identifier, should be in string.
 *
 * @return instance of the cached class.
 */
- (instancetype)instanceForNibNamed:(NSString *)nibName;

/**
 * @brief This is a method for get singleton instance from class name.
 *
 * @param nibName input nib name for identifier, should be in string.
 *
 * @return instance of the cached class.
 */
- (instancetype)instanceForClassNamed:(NSString *)className;

@end
