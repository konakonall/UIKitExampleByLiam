//
//  ViewController.m
//  UIKitExampleByLiam
//
//  Created by Liam on 2023/8/26.
//

#import "ViewController.h"
#import "ShimmerLabelViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor systemCyanColor] colorWithAlphaComponent:0.6];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startShimmerViewController];
}

- (void)startShimmerViewController {
    ShimmerLabelViewController *vc = [[ShimmerLabelViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

@end
