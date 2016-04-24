//
//  APTripFinderAppConstant.h
//  tripFinder
//
//  Created by Anson Ng on 3/13/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BMEnv) {
    BMEnvBeta = 0,
    BMEnvProduction = 1,
};

extern NSString * const BMEnvBetaApiUrl;
extern NSString * const BMEnvProductionApiUrl;