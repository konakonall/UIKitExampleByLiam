//
//  ShimmerLabel.m
//  UIKitExampleByLiam
//
//  Created by Liam on 2023/8/26.
//

#import "ShimmerLabel.h"

@interface ShimmerLabel()

@property (nonatomic, strong) UILabel *shimmerLabel;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ShimmerLabel

- (void)startShimmerAnimationWithColor:(UIColor *)shimmerColor
                              duration:(CFTimeInterval)shimmerDuration
                           repeatCount:(CGFloat)shimmerRepeatCount
                           repeatDelay:(CFTimeInterval)shimmerRepeatDelay {
    // 创建一个UILabel用于显示扫光效果
    UILabel *shimmerLabel = [[UILabel alloc] initWithFrame:self.bounds];
    shimmerLabel.attributedText = self.attributedText;
    shimmerLabel.textColor = shimmerColor;
    shimmerLabel.hidden = NO;
    shimmerLabel.numberOfLines = self.numberOfLines;
    [self addSubview:shimmerLabel];
    
    // 创建渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,
                             (id)[UIColor redColor].CGColor,
                             (id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@0.25, @0.5, @0.75];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    gradientLayer.frame = shimmerLabel.bounds;
    
    // 设置渐变图层作为扫光UILabel的遮罩
    shimmerLabel.layer.mask = gradientLayer;
    
    // 创建遮罩动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@0, @0, @0.25];
    animation.toValue = @[@0.75, @1, @1];
    animation.duration = shimmerDuration;
    animation.fillMode = kCAFillModeBoth;
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[animation];
    groupAnimation.duration = shimmerDuration + shimmerRepeatDelay;
    groupAnimation.repeatCount = shimmerRepeatCount;
    
    // 将动画添加到渐变图层
    [gradientLayer addAnimation:groupAnimation forKey:@"shimmerAnimation"];
    
    self.shimmerLabel = shimmerLabel;
    self.gradientLayer = gradientLayer;
}

- (void)stopShimmerAnimation {
    [self.gradientLayer removeAllAnimations];
    self.gradientLayer = nil;
    
    [self.shimmerLabel removeFromSuperview];
    self.shimmerLabel = nil;
}

@end
