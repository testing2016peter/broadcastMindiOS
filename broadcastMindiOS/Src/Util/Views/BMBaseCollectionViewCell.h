//
//  BMBaseCollectionViewCell.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+BMColor.h"
@interface BMBaseCollectionViewCell : UICollectionViewCell

/**
 * @brief Setting leading margin distance for cell.
 */
@property (assign, nonatomic) CGFloat leadingMargin;

/**
 * @brief Setting tailing margin distance for cell.
 */
@property (assign, nonatomic) CGFloat tailingMargin;

/**
 * @brief Setting leading margin distance for cell.
 */
@property (assign, nonatomic) CGFloat topBorderLeadingMargin;

/**
 * @brief Setting tailing margin distance for cell.
 */
@property (assign, nonatomic) CGFloat topBorderTailingMargin;

/**
 * @brief Setting border color for cell.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 * @brief Setting border height for cell.
 */
@property (assign, nonatomic) CGFloat borderHeight;

/**
 * @brief Setting border should show.
 */
@property (assign, nonatomic) BOOL borderHidden;
@property (assign, nonatomic) BOOL topBorderHidden;
@property (strong, nonatomic) CALayer *borderLayer;//bottom
@property (strong, nonatomic) CALayer *topBorderLayer;//top

- (void)setupView;
@end
