//
//  ShimmerLabel.h
//  UIKitExampleByLiam
//
//  Created by Liam on 2023/8/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShimmerLabel : UILabel

- (void)startShimmerAnimationWithColor:(UIColor *)shimmerColor
                              duration:(CFTimeInterval)shimmerDuration
                           repeatCount:(CGFloat)shimmerRepeatCount
                           repeatDelay:(CFTimeInterval)shimmerRepeatDelay;

- (void)stopShimmerAnimation;

@end

NS_ASSUME_NONNULL_END
