//
//  APNibSizeCalculator.m
//  tripFinder
//
//  Created by Anson Ng on 4/4/16.
//  Copyright © 2016 Anson Ng. All rights reserved.
//

#import "APNibSizeCalculator.h"


@interface APNibSizeCalculator ()

@property (nonatomic, strong) NSMutableDictionary *nibSizeDict;

@end

@implementation APNibSizeCalculator

+ (id)sharedInstance
{
    static APNibSizeCalculator *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        @synchronized(self) {
            instance = [[APNibSizeCalculator alloc] init];
            instance.nibSizeDict = [[NSMutableDictionary alloc] init];
        }
    });

    return instance;
}


- (CGSize)sizeForNibNamed:(NSString *)nibName
{
    return  [[APNibSizeCalculator sharedInstance] sizeForNibNamed:nibName withstyle:APNibDefaultScaling];
}


- (CGSize)sizeForNibNamed:(NSString *)nibName withstyle:(APNibSizeStyle)style
{
    return [self sizeForNibNamed:nibName withstyle:style fitSize:screenSize()];
}

- (CGSize)sizeForNibNamed:(NSString *)nibName withstyle:(APNibSizeStyle)style fitSize:(CGSize)containerSize
{
    CGSize nibSize = cgSizeZeroHeight();
    NSString *nibWithStyle = [NSString stringWithFormat:@"%@_%lu", nibName, (unsigned long)style];
    if ([self.nibSizeDict objectForKey:nibWithStyle]) {
        NSString *sizeString = [self.nibSizeDict objectForKey:nibWithStyle];
        nibSize = CGSizeFromString(sizeString);
    } else {
        UIView *nibView = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject];
        if (nibView != nil) {
            nibSize = nibView.bounds.size;
            CGSize targetSize = containerSize;
            CGFloat ratio = targetSize.width / nibSize.width;
            CGFloat ratioNibHeight = ratio * nibSize.height;
            CGFloat heightAdjustment = (ratioNibHeight - screenSize().width) / ratio;

            switch (style) {
                case APNibOriginalSize:
                    break;
                case APNibBottomFixedScaliing:
                    nibSize.width = ratio * nibSize.width;
                    nibSize.height = targetSize.width + heightAdjustment;
                    break;
                case APNibFixedHeightScaling:
                    nibSize.width = ratio * nibSize.width;
                    nibSize.height = nibSize.height;
                    break;
                case APNibDefaultScaling:
                default:
                    nibSize.width = ratio * nibSize.width;
                    nibSize.height = ratio * nibSize.height;
                    break;
            }
            [self.nibSizeDict setObject:NSStringFromCGSize(nibSize) forKey:nibWithStyle];
        }
    }
    return nibSize;
}

@end
