//
//  TranVC1Controller.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/7/3.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TranVC1Controller.h"
#import "GQTransition.h"
#import "TranVC2Controller.h"


@interface TranVC1Controller () <UIViewControllerTransitioningDelegate>

@end

@implementation TranVC1Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * nextButton = [[UIButton alloc] init];
    nextButton.frame = CGRectMake(100, 100, 100, 100);
    nextButton.backgroundColor = [UIColor redColor];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: nextButton];
    
}

- (void)nextButtonClick {
    TranVC2Controller *vc = [[TranVC2Controller alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [GQTransition enlargeTransitionWithType:GQTransitionTypeDismiss];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [GQTransition enlargeTransitionWithType:GQTransitionTypePresent];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
