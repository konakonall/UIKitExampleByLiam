//
//  ShimmerLabelViewController.m
//  UIKitExampleByLiam
//
//  Created by Liam on 2023/8/26.
//

#import "ShimmerLabelViewController.h"
#import "ShimmerLabel.h"

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>

@interface ShimmerLabelViewController ()

@property (nonatomic, strong) MASConstraint *progressWidthConstraint;

@end

@implementation ShimmerLabelViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startShimmerAnimationWithPlainText];
    
    [self startGradientLayouerAnimation];
}

- (void)startShimmerAnimationWithPlainText {
    ShimmerLabel *originalLabel = [[ShimmerLabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    originalLabel.text = @"Shimmering Text \nShimmering Content";
    originalLabel.textColor = [UIColor whiteColor];
    originalLabel.font = [UIFont systemFontOfSize:20.0];
    originalLabel.numberOfLines = 2;
    [self.view addSubview:originalLabel];
    
    [originalLabel startShimmerAnimationWithColor:[UIColor redColor] duration:1.5 repeatCount:HUGE_VALF repeatDelay:0.5];
}

- (void)startShimmerAnimationAttributedText {
    ShimmerLabel *originalLabel = [[ShimmerLabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    NSAttributedString *attributedHead = [[NSAttributedString alloc] initWithString:@"Shimmering Head \n" attributes:@{
        NSForegroundColorAttributeName:[UIColor whiteColor],
        NSFontAttributeName:[UIFont systemFontOfSize:20.0]
    }];
    NSAttributedString *attributedContent = [[NSAttributedString alloc] initWithString:@"Shimmering Content" attributes:@{
        NSForegroundColorAttributeName:[UIColor yellowColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16.0]
    }];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    [mutableAttributedString appendAttributedString:attributedHead];
    [mutableAttributedString appendAttributedString:attributedContent];
    
    originalLabel.attributedText = mutableAttributedString;
    originalLabel.numberOfLines = 2;
    
    [self.view addSubview:originalLabel];
    
    [originalLabel startShimmerAnimationWithColor:[UIColor redColor] duration:1.5 repeatCount:HUGE_VALF repeatDelay:0.5];
}

- (void)startGradientLayouerAnimation {
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    barView.backgroundColor = [UIColor systemMintColor];
    [self.view addSubview:barView];
    
    UIView *progressView = [[UIView alloc] init];
    UIColor *progressColor = [[UIColor systemRedColor] colorWithAlphaComponent:0.6];
    progressView.backgroundColor = progressColor;
    
    [barView addSubview:progressView];
    __block CGFloat progress = 0.1f;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.progressWidthConstraint = make.width.equalTo(barView).multipliedBy(progress);
        make.height.equalTo(barView);
        make.left.equalTo(barView.mas_left);
    }];
    UIImageView *borderView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"line.diagonal"]];
    [barView addSubview:borderView];
    
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(progressView.mas_right);
        make.centerY.equalTo(progressView.mas_centerY);
    }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        progress = progress + 0.1f;
        [self updateProgressWithAnimation:progressView duration:1.0f progress:progress];
        if (progress >= 1.0f) {
            [timer invalidate];
        }
    }];
}

- (void)updateProgressWithAnimation:(UIView *)progressView
                           duration:(NSTimeInterval)duration
                           progress:(CGFloat)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressWidthConstraint uninstall];
        [UIView animateWithDuration:duration animations:^{
            [progressView mas_updateConstraints:^(MASConstraintMaker *make) {
                NSLog(@"%f", progress);
                CGFloat nextProgress = MIN(progress, 1.0f);
                self.progressWidthConstraint = make.width.equalTo(progressView.superview).multipliedBy(progress);
            }];
            [progressView.superview layoutIfNeeded];
        }];
    });
}

@end
